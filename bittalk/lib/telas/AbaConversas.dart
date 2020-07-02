import 'dart:async';
import 'package:bittalk/meusWidgets/GreenCircleAvatar.dart';
import 'package:bittalk/meusWidgets/GreenText.dart';
import 'package:bittalk/model/Conversa.dart';
import 'package:bittalk/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {


  List<Conversa> _listaConversas = List();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  String _idUsuarioLogado;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDadosUsuario();
  }

  Stream<QuerySnapshot>_adicionarListenerConversas(){
    final stream = db.collection("conversas")
        .document(_idUsuarioLogado)
        .collection("ultima_conversa")
        .orderBy('dataHora', descending: true)
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
      _adicionaConversaNaLista(dados.documents);
    });
  }

  _adicionaConversaNaLista(List<DocumentSnapshot> snapshots){
    snapshots.forEach((snapshots) {
      Conversa conversa = new Conversa.nova(
          snapshots.data["idRemetente"],
          snapshots.data["idDestinatario"],
          snapshots.data["nome"],
          snapshots.data["mensagem"],
          snapshots.data["caminhoFoto"],
          snapshots.data["tipoMensagem"],
          snapshots.data["dataHora"]
      );
      _listaConversas.add(conversa);
    });
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    _adicionarListenerConversas();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
       stream: _controller.stream,
       builder: (contex, snapshot){
          switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: GreenText("Loading chat")
                      ),
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
                  if (snapshot.hasError) {
                    return GreenText("Error loading conversations");
                  } else {
                    QuerySnapshot querySnapshot = snapshot.data;
                      if(querySnapshot.documents.length == 0){
                          return Center(
                            child: GreenText("You have no message."),
                          );
                      }

                      return ListView.builder(
                        itemCount: _listaConversas.length,
                        itemBuilder: (context, indice){

                          List<DocumentSnapshot> conversas = querySnapshot.documents.toList();
                          DocumentSnapshot item = conversas[indice];

                          String urlImagem      = item["caminhoFoto"];
                          String tipoMensagem   = item["tipoMensagem"];
                          String mensagem       = item["mensagem"];
                          String nome           = item["nome"];
                          String idDestinatario = item["idDestinatario"];

                          Usuario usuario = Usuario();
                          usuario.nome = nome;
                          usuario.urlImagem = urlImagem;
                          usuario.idUsuario = idDestinatario;

                          return ListTile(

                            onTap: (){
                              Navigator.pushNamed(
                                  context,
                                  "/mensagens",
                                  arguments: usuario
                              );
                            },

                            contentPadding: EdgeInsets.fromLTRB(14, 1, 14, 1),
                            leading: GreenCircleAvatar(
                              raio: 23,
                              caminho: urlImagem,
                            ),
                            title: Text(
                              nome,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff00f004)
                              ),
                            ),
                            subtitle: Text(
                              mensagem,
                              style: TextStyle(
                                  color: Color(0xff3A6133),
                                  fontSize: 14
                              ),
                            ),
                          );
                        },
                      );
                  }
                break;
            }
          return null;
          },
    );


  }
}
