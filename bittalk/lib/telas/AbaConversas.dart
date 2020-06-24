import 'package:bittalk/model/Conversa.dart';
import 'package:flutter/material.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {

  List<Conversa> listaConversas = [
    Conversa(
      "José Renato",
      "Olá Tudo bem?",
      ""
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (context, indice){

      },
    );
  }
}
