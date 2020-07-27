import 'package:flutter/material.dart';
import '../constants.dart';


class BottonButton extends StatelessWidget {

  BottonButton({@required this.onTap, @required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        color: kBottonConteinerColour,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: kBottonConteinerHeight,
        child: Center(
          child: Text(
              buttonTitle,
              style: kLargeButtonTextStyle
          ),
        ),
      ),
    );
  }
}
