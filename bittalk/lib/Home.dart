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
  String _emailUsuarioLogado = "";

  ColorFilter _greyscale = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.100, 0.400, 0.300, 0, 90,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ]);

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff00f004), //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "bitTalk",
              style: TextStyle(color: Color(0xff00f004)),
            ),

            ColorFiltered(
              colorFilter: _greyscale,
              child: Image.asset(
                  "assets/images/icon.png",
                  height: 40
              ),
            )
          ],
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

