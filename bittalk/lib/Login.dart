import 'package:bittalk/Cadastro.dart';
import 'package:bittalk/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty &&
        email.contains("@") &&
        (email.contains(".com") || email.contains(".br"))) {
      if (senha.isNotEmpty) {
        _mensagemErro = "";
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;
        _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "E-mail inválido!";
      });
    }
  }

  _logarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){
      Navigator.pushReplacementNamed(context, "/home");
    }).catchError((erro){
      print("Erro de autenticação: " + erro.toString());
      setState(() {
        _mensagemErro = "Erro ao autenticar o usuário!";
      });
    });
  }

  Future _verificaUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    //auth.signOut();
    FirebaseUser usuarioLogado = await auth.currentUser();

    if(usuarioLogado != null){
      Navigator.pushReplacementNamed(context, "/home");
    }

  }

  @override
  void initState() {
    _verificaUsuarioLogado();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 32,
                      left: queryData.size.width * 0.2,
                      right: queryData.size.width * 0.2),
                  child: Image.asset(
                    "assets/images/logo.png",
                    //width: queryData.size.width*0.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00f004),
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerSenha,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00f004),
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                        hintText: "Senha",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 20, color: Color(0xff00f004)),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Color(0xff00f004), width: 2)),
                    color: Colors.black,
                    padding: EdgeInsets.fromLTRB(32, 11, 32, 11),
                    onPressed: () {

                      _validarCampos();

                    },
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? Cadastre-se!",
                      style: TextStyle(color: Colors.green),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Cadastro();
                      }));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
