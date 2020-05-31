import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alcool ou gasolina"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("images/logo.png")
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text("Saiba qual a melhor opção para o abastecimento do seu carro."),
            ),
            TextField(),
            TextField(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: RaisedButton(
                child: Text("Calcular"),
                onPressed: (){},
              ),
            )
          ],
        ),
      ),
    );
  }
}
