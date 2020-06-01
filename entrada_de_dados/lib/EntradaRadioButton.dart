import 'package:flutter/material.dart';

class EntradaRadioButton extends StatefulWidget {
  @override
  _EntradaRadioButtonState createState() => _EntradaRadioButtonState();
}

class _EntradaRadioButtonState extends State<EntradaRadioButton> {

  String __escolhaUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada dados"),
      ) ,
      body: Container(
        child: Column(
          children: <Widget>[
            RadioListTile(
              title: Text("Masculino"),
                value: "m",
                groupValue: __escolhaUsuario,
                onChanged: (String escolha){
                    setState(() {
                    __escolhaUsuario = escolha;
                    });
                }
            ),
            RadioListTile(
                title: Text("Feminino"),
                value: "f",
                groupValue: __escolhaUsuario,
                onChanged: (String escolha){
                  setState(() {
                    __escolhaUsuario = escolha;
                  });
                }
            ),
            RaisedButton(
              child: Text(
                "Salvar",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onPressed: (){
                print("Resultado: " + __escolhaUsuario);
              },
            )


            /*
            Text("Masculino"),
            Radio(
                value: "m",
                groupValue: __escolhaUsuario,
                onChanged: (String escolha){
                  setState(() {
                    __escolhaUsuario = escolha;
                  });
                }
            ),
            Text("Feminino"),
            Radio(
                value: "f",
                groupValue: __escolhaUsuario,
                onChanged: (String escolha){
                  setState(() {
                    __escolhaUsuario = escolha;
                  });
                }
            )*/


          ],
        ),
      ),
    );;
  }
}
