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
        iconTheme: IconThemeData(
          color: Color(0xff00f004), //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Home",
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

