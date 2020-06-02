import 'package:flutter/material.dart';

class EntradaSlider extends StatefulWidget {
  @override
  _EntradaSliderState createState() => _EntradaSliderState();
}

class _EntradaSliderState extends State<EntradaSlider> {
  
  double _valorSlider = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada dados"),
      ) ,
      body: Container(
        padding: EdgeInsets.all(60),
        child: Column(
          children: <Widget>[
            Slider(
                min: 0,
                max: 10,
                value: _valorSlider,
                label: "Valor Selecionado: " + _valorSlider.toString(),
                divisions: 10,
                activeColor: Colors.red,
                inactiveColor: Colors.black26,
                onChanged: (double valor){
                  setState(() {
                    _valorSlider = valor;
                  });
                  print(valor);
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
                    print("Valor selecionado: " + _valorSlider.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
