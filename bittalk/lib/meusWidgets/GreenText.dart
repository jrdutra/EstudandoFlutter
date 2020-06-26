import 'package:flutter/material.dart';

class GreenText extends StatefulWidget {

  //const GreenCircleAvatar({ Key key }) : super(key: key);

  String text;
  TextStyle style;

  GreenText(this.text,  {Key key, this.style = const TextStyle(color: Color(0xff00f004))}): super(key: key);

  @override
  _GreenText createState() => _GreenText();

}

class _GreenText extends State<GreenText> {

  @override
  Widget build(BuildContext context) {
      return Text(
        widget.text,
        style: widget.style
    );
  }
}