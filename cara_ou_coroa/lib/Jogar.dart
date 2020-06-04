import 'package:caraoucoroa/Resultado.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Jogar extends StatefulWidget {
  @override
  _JogarState createState() => _JogarState();
}

class _JogarState extends State<Jogar> {

  void _exibirResultado(){

    var itens = ["cara", "coroa"];
    var numero = Random().nextInt(itens.length);
    var resultado = itens[numero];

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Resultado(resultado)
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61bd86),
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset("imagens/logo.png"),
              GestureDetector(
                onTap: _exibirResultado,
                child: Image.asset("imagens/botao_jogar.png"),
              )
            ],
          ),
      ),
    );
  }
}
