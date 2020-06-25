import 'package:bittalk/Login.dart';
import 'package:bittalk/telas/AbaContatos.dart';
import 'package:bittalk/telas/AbaConversas.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}



class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController _tabController;
  List<String> _itensMenu = [
    "Configurações", "Deslogar"
  ];
  String _emailUsuarioLogado = "";

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuarioLogado = usuarioLogado.email;
    });

  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
    _tabController = TabController(
      length: 2,
      vsync: this
    );

  }

  _deslogarUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context){
              return Login();
            }
        )
    );
  }

  _escolhaMenuItem(String itemEscolhido){
    switch ( itemEscolhido ){
      case "Configurações":
        print("Configurações");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff00f004), //change your color here
        ),
        title: Text(
          "bitTalk",
          style: TextStyle(color: Color(0xff00f004)),
        ),
        backgroundColor: Colors.black,
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff00f004)
          ),
          controller: _tabController,
          indicatorColor: Color(0xff00f004),
          labelColor: Color(0xff00f004),
          tabs: <Widget>[
            Tab(text: "Conversas",),
            Tab(text: "Contatos",)
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color(0xff00f004),
                  width: 3
              )
            ),
            icon: Image.asset("assets/images/menu-icon.png"),
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
                  return _itensMenu.map((String item){
                      return PopupMenuItem<String>(
                        value: item,
                        child: Text(
                            item,
                          style: TextStyle(
                            color: Color(0xff00f004)
                          ),
                        ),
                      );
                  }).toList();
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AbaConversas(),
          AbaContatos()
        ],
      )
    );
  }
}

