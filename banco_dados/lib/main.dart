import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recuperarBancoDados() async{

      final caminhoBancoDados = await getDatabasesPath();
      final localBancoDados = join(caminhoBancoDados, "banco.db");

      var bd = await openDatabase(
        localBancoDados,
        version: 1,
        onCreate: (db, dbVersaoRecente){
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";
          db.execute(sql);
        }
      );
      return bd;
      //print("Aberto: " + bd.isOpen.toString() );
  }

  _salvar() async{
    
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": "JOAO",
      "idade" : 25
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo>:" + id.toString());
  }


  _listaUsuarios() async{
    Database bd = await _recuperarBancoDados();
    String sql = " SELECT * FROM usuarios";
    List usuarios = await bd.rawQuery(sql);
    print("Usuarios: " + usuarios.toString());
  }

  @override
  Widget build(BuildContext context) {

    _listaUsuarios();
    //_salvar();
    return Container();
  }
}
