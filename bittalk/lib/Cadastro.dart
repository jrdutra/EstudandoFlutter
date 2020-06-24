import 'package:bittalk/Home.dart';
import 'package:bittalk/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Controladores
  TextEditingController _controllerNome = TextEditingController(text: "Joao");
  TextEditingController _controllerEmail = TextEditingController(text: "jrdutra@hotmail.com");
  TextEditingController _controllerSenha = TextEditingController(text: "jrdutra123");
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
            _mensagemErro = "Senha deve conter mais de 6 caracteres";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "E-mail inválido!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "O nome precisa ter mais que 2 caracteres!";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email.toString(),
        password: usuario.senha
    ).then((firebaseUser) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context){
            return Home();
          }
        )
      );
    }).catchError((erro){
      print("Erro vindo do Firebase: " + erro.toString());
      print("Email: " + usuario.email);
        setState(() {
          _mensagemErro = "Verifique os campos e tente novamente.";
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
            Text(
              "Cadastro",
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
                        hintText: "Nome",
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
                      "Cadastrar",
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
