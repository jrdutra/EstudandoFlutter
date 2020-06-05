import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "Resultado";

  _recuperarCep() async {

    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    print(
        "Logradouro: " + logradouro +
        " Complemento: " + complemento +
        " Bairro: " + bairro +
        " Localidade: " + localidade
    );
    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}, ${localidade}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de Serviço WEB"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP: Ex: 27963762"
              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              color: Colors.amber,
              child: Text("Clique Aqui"),
              onPressed: _recuperarCep,
            ),
            Text(
              _resultado,
              style: TextStyle(
                  color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}
