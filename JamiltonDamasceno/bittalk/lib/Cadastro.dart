import 'package:bittalk/Home.dart';
import 'package:bittalk/meusWidgets/GreenText.dart';
import 'package:bittalk/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Controladores
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty && nome.length > 2) {
      if (email.isNotEmpty && email.contains("@") &&
          (email.contains(".com") || email.contains(".br"))) {
        if (senha.isNotEmpty && senha.length > 5 ) {
          _mensagemErro = "";

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          _cadastrarUsuario(usuario);
        } else {
          setState(() {
            _mensagemErro = "Password must contain more than 6 characters";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Invalid email!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "The name must be longer than 2 characters!";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email.toString(),
        password: usuario.senha
    ).then((firebaseUser) {
      Firestore db = Firestore.instance;
      db.collection("usuarios")
      .document(firebaseUser.user.uid)
      .setData(usuario.toMap());
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_)=>false);
    }).catchError((erro){
        setState(() {
          _mensagemErro = "Check the fields and try again.";
        });
    });



  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff00f004), //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GreenText("Sign up"),
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
                      left: queryData.size.width * 0.25,
                      right: queryData.size.width * 0.25),
                  child: Image.asset(
                    "assets/images/user-icon.png",
                    //width: queryData.size.width*0.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00f004),
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
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
                        )),
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
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Register",
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
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(color: Colors.red, fontSize: 13),
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
