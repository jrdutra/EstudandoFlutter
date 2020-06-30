import 'dart:async';
import 'dart:ffi';

import 'package:bittalk/meusWidgets/CommandText.dart';
import 'package:bittalk/meusWidgets/GreenText.dart';
import 'package:bittalk/model/Conversa.dart';
import 'package:bittalk/model/Mensagem.dart';
import 'package:bittalk/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;

  Mensagens(this.contato);

  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {

  TextEditingController _controlerMensagem = TextEditingController();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  ScrollController _scrollController = ScrollController();
  String _idUsuarioLogado = "";
  String _idUsuarioDestinatario = "";
  Firestore db = Firestore.instance;
  double alturaBase;


  _enviarMensagem() {
    String textoMensagem = _controlerMensagem.text;
    if (!textoMensagem.isEmpty) {
      Mensagem mensagem = Mensagem();
      mensagem.idUsuario = _idUsuarioLogado;
      mensagem.mensagem = textoMensagem;
      mensagem.urlImagem = "";
      mensagem.tipo = "texto";
      mensagem.dataHora = DateTime.now();

      _salvarMensagem(_idUsuarioLogado, _idUsuarioDestinatario, mensagem);
      _salvarMensagem(_idUsuarioDestinatario, _idUsuarioLogado, mensagem);

      //Salvar conversa
      _salvarConversa(mensagem);

    }
  }

  _salvarConversa(Mensagem msg){
      Conversa cRemetente = Conversa();
      cRemetente.idRemetente = _idUsuarioLogado;
      cRemetente.idDestinatario = _idUsuarioDestinatario;
      cRemetente.mensagem = msg.mensagem;
      cRemetente.nome = widget.contato.nome;
      cRemetente.caminhoFoto = widget.contato.urlImagem;
      cRemetente.tipoMensagem = msg.tipo;
      cRemetente.salvar();

      Conversa cDestinatario = Conversa();
      cDestinatario.idRemetente = _idUsuarioDestinatario;
      cDestinatario.idDestinatario = _idUsuarioLogado;
      cDestinatario.mensagem = msg.mensagem;
      cDestinatario.nome = widget.contato.nome;
      cDestinatario.caminhoFoto = widget.contato.urlImagem;
      cDestinatario.tipoMensagem = msg.tipo;
      cDestinatario.salvar();

  }

  _salvarMensagem(String idRemetende, String idDestinatario, Mensagem msg) async {
    await db
        .collection("mensagens")
        .document(idRemetende)
        .collection(idDestinatario)
        .add(msg.toMap());

    _controlerMensagem.clear();
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    _idUsuarioDestinatario = widget.contato.idUsuario;
    _adicionarListenerConversas();
  }

  Stream<QuerySnapshot> _adicionarListenerConversas(){
    final stream = db
        .collection("mensagens")
        .document(_idUsuarioLogado)
        .collection(_idUsuarioDestinatario).orderBy('dataHora', descending: false)
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
      Timer(Duration(seconds: 1), (){
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
  }

  double _getSmartBannerHeight(BuildContext context) {
    MediaQueryData mediaScreen = MediaQuery.of(context);
    double dpHeight = mediaScreen.orientation == Orientation.portrait
        ? mediaScreen.size.height
        : mediaScreen.size.width;
    if (dpHeight <= 400.0) {
      return 39.0;
    }
    if (dpHeight > 720.0) {
      return 99.0;
    }
    return 59.0;
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();

  }

  @override
  Widget build(BuildContext context) {

    alturaBase = _getSmartBannerHeight(context);

    var caixaMensagem = Container(
      padding: EdgeInsets.all(0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 2),
              child: TextField(
                controller: _controlerMensagem,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff00f004),
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                    hintText: "Command",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    //prefixIcon: IconButton(
                    //  icon: Icon(Icons.camera),
                    //  onPressed: enviarFoto,
                    //)
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.send,
              color: Color(0xff00f004),
            ),
            mini: true,
            onPressed: _enviarMensagem,
          )
        ],
      ),
    );

    var stream = StreamBuilder(
      stream: _controller.stream,
      builder: (contex, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [
                  GreenText("Carregando mensagens"),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                        backgroundColor: Color(0xff00f004),
                        strokeWidth: 2.0
                    ),
                  )
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            QuerySnapshot querySnapshot = snapshot.data;
            if (snapshot.hasError) {
              return Expanded(
                child: GreenText("Erro ao carregar dados"),
              );
            } else {
              print("Itens: " + querySnapshot.documents.toList().toString());
              return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                itemCount: querySnapshot.documents.length,
                itemBuilder: (context, indice) {

                  List<DocumentSnapshot> mensagens = querySnapshot.documents.toList();
                  DocumentSnapshot item = mensagens[indice];



                  bool isContact = false;
                  Alignment alinhamento = Alignment.centerLeft;
                  TextStyle style = TextStyle(color: Color(0xff00f004));

                  if (_idUsuarioLogado != item["idUsuario"]) {
                    style = TextStyle(color: Colors.green);
                    alinhamento = Alignment.centerLeft;
                    isContact = true;
                  }

                  return Align(
                    alignment: alinhamento,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: CommandText(
                          isContact? "\$" + widget.contato.nome + ": " + item["mensagem"] : "\$Eu: " + item["mensagem"],
                          style: style,
                        )
                      ),
                    ),
                  );
                },
              ));
            }
            break;
        }
        return null;
      },
    );



    return Scaffold(
      appBar: AppBar(
        title: Text(
          "\$" + widget.contato.nome,
          style: TextStyle(color: Color(0xff00f004)),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Color(0xff00f004), //change your color here
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                _keyboardIsVisible()
                    ? 9
                    :alturaBase
            ),
            child: Column(
              children: [stream, caixaMensagem],
            ),
          ),
        ),
      ),
    );
  }
}
