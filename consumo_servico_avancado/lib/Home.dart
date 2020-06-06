import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<Map> _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: _recuperarPreco(),
        builder: (context, snapshot){
          String resultado;
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              resultado = "Carregando...";
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if( snapshot.hasError ){
                resultado = "Houyve um erro ao carregar o estado...";
              }else{
                double valor = snapshot.data["BRL"]["buy"];
                resultado = "Preço do bitcoin: R\$ " + valor.toString();
              }
              break;
          }
          return Center(
            child: Text(resultado),
          );
        },
    );
  }
}
