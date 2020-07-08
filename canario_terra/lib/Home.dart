import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _menuAberto = false;
  IconData _iconeCortina = Icons.keyboard_arrow_down;
  double _targetValue = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Canário da terra"),
      ),*/
      body: Column(
        children: [
              TweenAnimationBuilder(
              tween: Tween<double>(begin: 100, end: _targetValue),
              duration: Duration(milliseconds: 600),
              curve: Curves.fastOutSlowIn,
              builder: (BuildContext context, double altura, Widget child) {
                return Container(
                  color: Colors.green,
                  padding: EdgeInsets.fromLTRB(10,30,10,1),
                  height: altura,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        altura > 150
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0, end: _targetValue),
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                                builder: (BuildContext context, double alturaWhats, Widget child) {
                                  return Image.asset(
                                    "assets/images/whatsIcon.png",
                                    height: _menuAberto?alturaWhats*0.5:0,
                                  );
                                }
                            ),
                          )
                        : Container(),
                      Row(
                        mainAxisAlignment: _menuAberto? MainAxisAlignment.center:MainAxisAlignment.start,
                        children: [
                          Text(
                            _menuAberto?"Participe do grupo no WhatsApp":"Canário da Terra",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            _menuAberto = !_menuAberto;
                            if(_menuAberto){
                              _iconeCortina = Icons.keyboard_arrow_up;
                              _targetValue = 200;
                            }else{
                              _iconeCortina = Icons.keyboard_arrow_down;
                              _targetValue = 100;
                            }
                          });
                        },
                        child: Icon(
                          _iconeCortina,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          //Conteudo do app
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Conteudo aqui")
              ],
            ),
          ),
        ],
      )
    );
  }
}
