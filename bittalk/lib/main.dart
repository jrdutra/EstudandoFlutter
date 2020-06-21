import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
            "assets/images/logo.png",
          height: 40,
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
              "Conteúdo do APP",
            style: TextStyle(
              color: Color(0xff00f004)
            ),
          ),
        ),
      ),
    );
  }
}

