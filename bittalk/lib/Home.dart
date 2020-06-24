import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}



class _HomeState extends State<Home> {

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

    _recuperarDadosUsuario();
    super.initState();
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
            Image.asset(
              "assets/images/icon.png",
              height: 40,
            ),
          ],
        ),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          child: Container(
            color: Color(0xff00f004),
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            _emailUsuarioLogado,
            style: TextStyle(
                color: Color(0xff00f004)
            ),
          ),
        ),
      ),
    );
  }
}

