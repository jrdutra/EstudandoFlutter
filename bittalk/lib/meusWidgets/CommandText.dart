import 'package:flutter/material.dart';

class CommandText extends StatefulWidget {

  //const GreenCircleAvatar({ Key key }) : super(key: key);

  String text;
  TextStyle style;

  CommandText(this.text,  {Key key, this.style = const TextStyle(color: Color(0xff00f004))}): super(key: key);

  @override
  _CommandText createState() => _CommandText();

}

class _CommandText extends State<CommandText> {



  @override
  Widget build(BuildContext context) {

      TextStyle style = widget.style;
      String texto = widget.text;
      List<Map<String, dynamic>> listaCores;

      listaCores = [
        {
        "simbolo": ".b.",
        "cor": 0xff0000ff
        },
        {
          "simbolo": ".r.",
          "cor": 0xffff0000
        },
        {
          "simbolo": ".y.",
          "cor": 0xffFFE400
        },
        {
          "simbolo": ".pi.",
          "cor": 0xffFF0083
        },
        {
          "simbolo": ".pu.",
          "cor": 0xff7C00FF
        },
        {
          "simbolo": ".pu.",
          "cor": 0xff7C00FF
        },
        {
          "simbolo": ".lb.",
          "cor": 0xff00FFFB
        },
        {
          "simbolo": ".g.",
          "cor": 0xff7F7F7F
        },
        {
          "simbolo": ".w.",
          "cor": 0xffFFFFFF
        },
        {
          "simbolo": ".lg.",
          "cor": 0xff61FFA4
        },
        {
          "simbolo": ".ly.",
          "cor": 0xffFFF9A0
        },
      ];

      listaCores.forEach((cor) {
        if(widget.text.contains(cor["simbolo"])){
          texto = null;
          texto = widget.text.replaceAll(new RegExp(cor["simbolo"]),'');
          style = null;
          style = TextStyle(color: Color(cor["cor"]));
        }
      });


      return Text(
          texto,
        style: style
    );
  }
}