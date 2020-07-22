import 'package:flutter/material.dart';
import 'dart:math';
void main() => runApp(
      MaterialApp(
        home: BallPage(),
      ),
    );

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Ask Me Anything"),
        backgroundColor: Colors.blue[900],
      ),
      body: Ball(),
      backgroundColor: Colors.blue,
    );
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {

  int _ballNumber = Random().nextInt(5) + 1;

  _randomizeBallNumber(){
    setState(() {
      _ballNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: (){
          _randomizeBallNumber();
        },
        child: Image.asset("images/ball$_ballNumber.png"),
      ),
    );
  }
}


