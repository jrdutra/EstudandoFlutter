import 'package:bittalk/Home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Firestore.instance
  .collection("usuarios")
  .document("001")
  .setData({"nome":"jamilton"});

  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
