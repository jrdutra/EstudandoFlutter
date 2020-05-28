import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeStatful()
  ));
}

class HomeStatful extends StatefulWidget {
  @override
  _HomeStatfulState createState() => _HomeStatfulState();
}

class _HomeStatfulState extends State<HomeStatful> {
  var _texto = "João Ricardo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                print("Clicado");
                setState(() {
                  _texto = "Curso Flutter";
                });
              },
              child: Text("Clique aqui"),
            ),
            Text("Nome:  $_texto")
          ],
        ),
      )

    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var _titulo = "Instagram";

    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text("Conteúdo principal"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightGreen,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Text("Texto 1"),
              Text("Texto 2")
            ],
          ),
        ),
      ),
    );
  }
}
