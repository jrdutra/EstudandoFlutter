import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 32,
                      left: queryData.size.width*0.2,
                      right: queryData.size.width*0.2
                  ),
                  child: Image.asset(
                      "assets/images/logo.png",
                      //width: queryData.size.width*0.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
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
                      )
                    ),
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(

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
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff00f004)
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            color:Color(0xff00f004),
                            width: 2
                        )
                    ),
                    color: Colors.black,
                    padding: EdgeInsets.fromLTRB(32, 11, 32, 11),
                    onPressed: (){

                    },
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? Cadastre-se!",
                      style: TextStyle(
                        color: Colors.green
                      ),
                    ),
                    onTap: (){

                    },
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
