import 'package:bittalk/meusWidgets/GreenText.dart';
import 'package:bittalk/model/Mensagem.dart';
import 'package:bittalk/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mensagens extends StatefulWidget {
  Usuario contato;

  Mensagens(this.contato);

  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  TextEditingController _controlerMensagem = TextEditingController();
  String _idUsuarioLogado = "";
  String _idUsuarioDestinatario = "";
  Firestore db = Firestore.instance;

  List<String> listaMensagens = ["Mensagem 1", "Mensagem 2"];

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
    }
  }

  _salvarMensagem(
      String idRemetende, String idDestinatario, Mensagem msg) async {
    await db
        .collection("mensagens")
        .document(idRemetende)
        .collection(idDestinatario)
        .add(msg.toMap());

    _controlerMensagem.clear();
  }

  enviarFoto() {}

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    _idUsuarioDestinatario = widget.contato.idUsuario;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
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
                    hintText: "Digite uma mensagem...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: enviarFoto,
                    )),
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
      stream: db
          .collection("mensagens")
          .document(_idUsuarioLogado)
          .collection(_idUsuarioDestinatario).orderBy('dataHora', descending: false)
          .snapshots(),
      builder: (contex, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [
                  GreenText("Carregando mensagens"),
                  CircularProgressIndicator(
                      backgroundColor: Color(0xff00f004), strokeWidth: 2.0)
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
              return Expanded(
                  child: ListView.builder(
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
                        child: GreenText(
                          isContact
                              ? "\$" + widget.contato.nome + ": " + item["mensagem"]
                              : "\$Eu: " + item["mensagem"],
                          style: style,
                        ),
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

    var listView = Expanded(
        child: ListView.builder(
      itemCount: listaMensagens.length,
      itemBuilder: (context, indice) {
        bool isContact = false;
        Alignment alinhamento = Alignment.centerLeft;
        TextStyle style = TextStyle(color: Color(0xff00f004));
        if (indice % 2 == 0) {
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
              child: GreenText(
                isContact
                    ? "\$" + widget.contato.nome + ": " + listaMensagens[indice]
                    : "\$Eu: " + listaMensagens[indice],
                style: style,
              ),
            ),
          ),
        );
      },
    ));

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
            padding: EdgeInsets.all(16),
            child: Column(
              children: [stream, caixaMensagem],
            ),
          ),
        ),
      ),
    );
  }
}
