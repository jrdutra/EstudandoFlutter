import 'package:flutter/material.dart';

class GreenCircleAvatar extends StatefulWidget {

  //const GreenCircleAvatar({ Key key }) : super(key: key);

  String caminho;
  double raio;

  GreenCircleAvatar({Key key, String this.caminho,  double this.raio}): super(key: key);

  @override
  _GreenCircleAvatar createState() => _GreenCircleAvatar();

}

class _GreenCircleAvatar extends State<GreenCircleAvatar> {

  ColorFilter _greenScale = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.100, 0.400, 0.300, 0, 90,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
        colorFilter: _greenScale,
        child: CircleAvatar(
          radius: widget.raio,
          backgroundColor: Colors.green,
          backgroundImage: widget.caminho != null? NetworkImage(widget.caminho): null,
        )
    );
  }
}