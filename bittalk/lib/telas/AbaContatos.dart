import 'package:bittalk/meusWidgets/GreenCircleAvatar.dart';
import 'package:bittalk/meusWidgets/GreenText.dart';
import 'package:bittalk/model/Conversa.dart';
import 'package:bittalk/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  List<Conversa> listaConversas = [
    Conversa("Ana Clara", "Olá Tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=80804e1a-f6a4-478c-aa9e-2fb3aab5f663"),
    Conversa("Pedro Silva", "ME manda o nome daquela série??",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=a11d2035-3f4a-4a9e-963d-424e2b9a1427"),
    Conversa("Marcela Almeida", "Olá Tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=f20bb8d0-e7e0-48eb-b0df-98e9a44b647b"),
    Conversa("José Renato", "Olá Tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=c06ce53b-beb5-49a6-b155-e53449568f90"),
    Conversa("Jamilton Damasceno", "Olá Tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=f8056ce7-3803-4231-8196-7ce21d1115aa"),
  ];

  Future<List<Usuario>> _recuperarContatos() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot =
        await db.collection("usuarios").getDocuments();

    List<Usuario> listaUsuarios = List();

    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;
      Usuario usuario = Usuario();
      usuario.email = dados["email"];
      usuario.nome = dados["nome"];
      usuario.urlImagem = dados["urlImagem"];
      listaUsuarios.add(usuario);
    }

    return listaUsuarios;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContatos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  GreenText("Carregando Contatos"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, indice) {

                List<Usuario> listaItens = snapshot.data;
                Usuario usuario = listaItens[indice];
                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(14, 1, 14, 1),
                  leading: GreenCircleAvatar(
                    raio: 25,
                    caminho: usuario.urlImagem,
                  ),
                  title:GreenText(usuario.nome)
                );
              },
            );
            break;
        }
        return null;
      },
    );
  }
}
