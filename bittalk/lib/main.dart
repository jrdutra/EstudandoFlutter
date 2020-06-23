import 'package:bittalk/Home.dart';
import 'package:bittalk/Login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {

  //WidgetsFlutterBinding.ensureInitialized();
  //Firestore.instance
  //.collection("usuarios")
  //.document("001")
  //.setData({"nome":"jamilton"});

  runApp(MaterialApp(
    theme: ThemeData(
        fontFamily: 'Consolas',
        backgroundColor: Colors.black,
        primaryColor: Color(0xff00f004),
        accentColor: Colors.green,
        cursorColor: Color(0xff00f004),
        hintColor: Color(0xff3A6133)
    ),
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}
