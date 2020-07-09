import 'package:canarioterra/widgets/BarraAnimada.dart';
import 'package:canarioterra/models/Audio.dart';
import 'package:canarioterra/widgets/CardPlayer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //------
  //ADMOB
  //-----
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-5851652075835518/7918503067',
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  BannerAd _bannerAd;
  //------
  //FIM ADMOB
  //-----

  @override
  void initState() {
    //ADMOB
    FirebaseAdMob.instance.initialize(
        appId: 'ca-app-pub-5851652075835518~6927944899'
    );
    _bannerAd = myBanner..load()..show(anchorType: AnchorType.bottom);
    //FIM ADDMOB
    super.initState();

  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  double _getSmartBannerHeight(BuildContext context) {
    MediaQueryData mediaScreen = MediaQuery.of(context);
    double dpHeight = mediaScreen.orientation == Orientation.portrait
        ? mediaScreen.size.height
        : mediaScreen.size.width;
    if (dpHeight <= 400.0) {
      return 39.0;
    }
    if (dpHeight > 720.0) {
      return 99.0;
    }
    return 59.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          BarraAnimada()
        ],
      )
    );
  }
}
