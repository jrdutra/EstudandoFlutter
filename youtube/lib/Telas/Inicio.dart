import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {

    Api api = Api();

    api.pesquisar("");

    return Container(
      child: Center(
        child: Text(
          "Inicio",
          style: TextStyle(
              fontSize: 25
          ),
        ),
      ),
    );
  }
}
