import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/Telas/Biblioteca.dart';
import 'package:youtube/Telas/EmAlta.dart';
import 'package:youtube/Telas/Inicio.dart';
import 'package:youtube/Telas/Inscricao.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Inicio(),
      EmAlta(),
      Inscricao(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
            "imagens/youtube.png",
          width: 100,
        ),
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              
                String res = await showSearch(context: context, delegate: CustomSearchDelegate());
                print("Rsultado digitado: "  + res);
            },
          ),


        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice){
            setState(() {
              _indiceAtual = indice;
            });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.orange,
            title: Text("Início"),
            icon: Icon(Icons.home),

          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.blue,
            title: Text("Em Alta"),
            icon: Icon(Icons.whatshot),

          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.pink,
            title: Text("Inscrições"),
            icon: Icon(Icons.subscriptions),

          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.amber,
            title: Text("Biblioteca"),
            icon: Icon(Icons.folder),

          ),

        ],
      ),
    );
  }
}
