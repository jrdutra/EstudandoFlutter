import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {

  int leftDiceNumber = Random().nextInt(6) + 1;
  int righttDiceNumber = Random().nextInt(6) + 1;

  _randomizeDice(){
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      righttDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
                onPressed: (){
                    _randomizeDice();
                },
                child: Image.asset("images/dice$leftDiceNumber.png")
            ),
          ),
          Expanded(
            child: FlatButton(
                onPressed: (){
                  _randomizeDice();
                },
                child: Image.asset("images/dice$righttDiceNumber.png")
            ),
          )
        ],
      ),
    );
  }
}

