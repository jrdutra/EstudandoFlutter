import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BarraAnimada extends StatefulWidget {
  @override
  _BarraAnimadaState createState() => _BarraAnimadaState();
}

class _BarraAnimadaState extends State<BarraAnimada> {

  bool _menuAberto = false;
  IconData _iconeCortina = Icons.keyboard_arrow_down;
  double _targetValue = 100;

  _openWhatsGroup() async {
    const url = 'https://chat.whatsapp.com/BD2skRHy4iiKmPVuZMNjeW';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não pode abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
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
                      return Column(
                        children: [
                            Image.asset(
                              "assets/images/canario_png.png",
                              height: _menuAberto?alturaWhats*0.45:0,
                            ),
                            GestureDetector(
                              child: Image.asset(
                                "assets/images/whatsIcon.png",
                                height: _menuAberto?alturaWhats*0.19:0,
                              ),
                              onTap: _openWhatsGroup,
                            )
                        ],
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
                      _targetValue = MediaQuery.of(context).size.height-200;

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
    );
  }
}
