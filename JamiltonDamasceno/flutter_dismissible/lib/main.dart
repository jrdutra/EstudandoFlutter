import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    List _lista = ["Joao Dutra", "Maria", "Joao", "Carla"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dismissible"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: _lista.length,
                  itemBuilder: (context, index){

                    final item = _lista[index];

                    return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        secondaryBackground: Container(
                          color: Colors.lightGreenAccent,
                        ),
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction){
                          _lista.removeAt(index);
                          print("Direcao: " + direction.toString());
                        },
                        key: Key(item),
                        child:  ListTile(
                          title: Text(item),
                        )
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

