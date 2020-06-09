import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCampo = TextEditingController();

  String _textoSalvo = "Nada Salvo";

  _salvar() async{

    String valorDigitado = _controllerCampo.text;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("nome", valorDigitado);

    setState(() {
      _controllerCampo.text = "";
    });



    print("Salvo: " + valorDigitado);

  }

  _recuperar() async{

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "Sem valor";
    });
    print("Recuperado : " + _textoSalvo);
  }

  _remover()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Text(
              _textoSalvo,
              style: TextStyle(
                fontSize: 28
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Digite Algo"
                ),
                controller: _controllerCampo,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text("Salvar"),
                  onPressed: _salvar,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text("Recuperar"),
                  onPressed: _recuperar,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text("Remover"),
                  onPressed: _remover,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
