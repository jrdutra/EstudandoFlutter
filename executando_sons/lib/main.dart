import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AudioPlayer audioPlayer = AudioPlayer();

  _executar() async{

    String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
    int result = await audioPlayer.play(url);
    if (result == 1) {
      // success
    }

  }

  @override
  Widget build(BuildContext context) {

    _executar();

    return Container();
  }
}
