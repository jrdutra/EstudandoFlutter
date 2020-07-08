import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class CardPlayer extends StatefulWidget {

  String _caminhoAudio;
  String _textoAudio;
  String _textoTitulo;

  CardPlayer(this._caminhoAudio, this._textoAudio, this._textoTitulo);

  @override
  _CardPlayerState createState() => _CardPlayerState();
}

class _CardPlayerState extends State<CardPlayer> {

  AudioPlayer audioPlayer = new AudioPlayer();
  AudioCache audioCache = new AudioCache(prefix: "audios/");
  double _volume = 1;
  IconData _iconePlayStop = Icons.play_arrow;
  bool _estaExecutando = false;
  String _textoAudio = "Sem audio";

  _executar() async {
    audioPlayer.setVolume(_volume);
    audioPlayer = await audioCache.play(widget._caminhoAudio);
    _estaExecutando = true;
    setState(() {
      _textoAudio = widget._textoAudio;
    });

    //Musa o icone
    _iconePlayStop = Icons.stop;
    audioPlayer.onPlayerCompletion.listen((event) {
      //setState(() {
      //  _iconePlayStop = Icons.play_arrow;
      //  _estaExecutando = false;
      //});
      audioPlayer.resume();
    });
  }

  _parar() async{
    int resultado = await audioPlayer.stop();
    _estaExecutando = false;
    setState(() {
      _iconePlayStop = Icons.play_arrow;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _textoAudio = widget._textoAudio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90.0,
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 30.0,
              decoration: new BoxDecoration(
                color: Colors.grey[850],
                borderRadius:
                new BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.5, 6.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget._textoTitulo,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            Container(
                height: 60.0,
                decoration: new BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius:
                  new BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0)
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.5, 6.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlatButton(
                            child: Column(
                              children: [Icon(
                                _iconePlayStop,
                                size: 50,
                              )],
                            ),
                            onPressed: (){
                              if(_estaExecutando){
                                _parar();
                              }else{
                                _executar();
                              }

                            },
                          ),
                          Text(
                              _textoAudio
                          )
                        ],
                      ),
                    ]
                )
            ),
          ],
        )
    );
  }
}
