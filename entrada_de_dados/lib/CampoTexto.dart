import 'package:flutter/material.dart';

class CampoTexto extends StatefulWidget {
  @override
  _CampoTextoState createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ) ,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(32),
            child: TextField(
              //text
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite um valor"
              ),
              onSubmitted: (String texto){
                print(texto);
              },
              controller: _textEditingController,
            ),
          ),
          RaisedButton(
            child: Text("Salvar"),
            color: Colors.lightGreen,
            onPressed: (){
                print("Valor digitado:" + _textEditingController.text);
            },
          )

        ],
      ),
    );
  }
}
