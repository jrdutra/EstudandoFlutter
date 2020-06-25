import 'package:bittalk/meusWidgets/GreenCircleAvatar.dart';
import 'package:bittalk/model/Conversa.dart';
import 'package:flutter/material.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {

  ColorFilter _greyscale = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.100, 0.400, 0.300, 0, 90,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ]);


  List<Conversa> listaConversas = [
    Conversa(
      "Ana Clara",
      "Olá Tudo bem?",
      "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=80804e1a-f6a4-478c-aa9e-2fb3aab5f663"
    ),
    Conversa(
        "Pedro Silva",
        "ME manda o nome daquela série??",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=a11d2035-3f4a-4a9e-963d-424e2b9a1427"
    ),
    Conversa(
        "Marcela Almeida",
        "Olá Tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=f20bb8d0-e7e0-48eb-b0df-98e9a44b647b"
    ),
    Conversa(
        "José Renato",
        "Olá Tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=c06ce53b-beb5-49a6-b155-e53449568f90"
    ),
    Conversa(
        "Jamilton Damasceno",
        "Olá Tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/bittalk-708e5.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=f8056ce7-3803-4231-8196-7ce21d1115aa"
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (context, indice){
          Conversa conversa = listaConversas[indice];

          return ListTile(
            contentPadding: EdgeInsets.fromLTRB(14, 1, 14, 1),
            leading: GreenCircleAvatar(
              raio: 23,
              caminho: conversa.caminhoFoto,
            ),
            title: Text(
              conversa.nome,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff00f004)
              ),
            ),
            subtitle: Text(
              conversa.mensagem,
              style: TextStyle(
                color: Color(0xff3A6133),
                fontSize: 14
              ),
            ),
          );
      },
    );
  }
}
