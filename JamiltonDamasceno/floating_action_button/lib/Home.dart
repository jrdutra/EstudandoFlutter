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
        backgroundColor: Colors.purple,
        title: Text("Floating Action Button"),
      ),
      body: Text("Conteúdo"),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //floatingActionButton: FloatingActionButton(
      floatingActionButton: FloatingActionButton.extended(
        elevation: 9,
        backgroundColor: Colors.purple,
        icon: Icon(Icons.add_shopping_cart),
        label: Text("Adicionar"),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(2)
        ),
        /*child: Icon(Icons.add),
        onPressed: (){
          print("Resultado: Botão pressioando.");
        },*/
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purpleAccent,
        //shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.menu),
            )
          ],
        ),
      ),
    );
  }
}
