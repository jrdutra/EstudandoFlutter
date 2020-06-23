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
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                      "assets/images/logo.png",
                      width: queryData.size.width*0.6,
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
                      contentPadding: EdgeInsets.fromLTRB(32, 7, 32, 7),
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
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00f004),
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 7, 32, 7),
                        hintText: "Senha",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )
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
