import 'package:canarioterra/widgets/CardPlayer.dart';
import 'package:flutter/material.dart';
import 'package:canarioterra/models/Audio.dart';

class Corpo extends StatefulWidget {
  @override
  _CorpoState createState() => _CorpoState();
}

class _CorpoState extends State<Corpo> {

  double _getSmartBannerHeight(BuildContext context) {
    MediaQueryData mediaScreen = MediaQuery.of(context);
    double dpHeight = mediaScreen.orientation == Orientation.portrait
        ? mediaScreen.size.height
        : mediaScreen.size.width;
    if (dpHeight <= 400.0) {
      return 32.0;
    }
    if (dpHeight > 720.0) {
      return 90.0;
    }
    return 50.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100, bottom: _getSmartBannerHeight(context)),
      child: ListView.builder(
        itemCount: Audio.getAudioTamanho(),
        itemBuilder: (context, index) {
          Map<String, String> audio = Audio.getAudioIndice(index);
          String caminho = audio["caminhoAudio"];
          String texto = audio["textoAudio"];
          String titulo = "Canto";
          return Padding(
              padding: const EdgeInsets.all(10),
              child: CardPlayer(caminho, texto, titulo)
          );
        },
      ),
    );
  }
}
