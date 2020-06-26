import 'package:bittalk/Cadastro.dart';
import 'package:bittalk/Configuracoes.dart';
import 'package:bittalk/Home.dart';
import 'package:bittalk/Login.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) {
          return Login();
        });
      case "/login":
        return MaterialPageRoute(builder: (_) {
          return Login();
        });
      case "/cadastro":
        return MaterialPageRoute(builder: (_) {
          return Cadastro();
        });
      case "/home":
        return MaterialPageRoute(builder: (_) {
          return Home();
        });
      case "/configuracoes":
        return MaterialPageRoute(builder: (_) {
          return Configuracoes();
        });
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Text(
          "Tela não encontrada",
          style: TextStyle(fontSize: 16, color: Color(0xff00f004)),
        ),
      );
    });
  }
}
