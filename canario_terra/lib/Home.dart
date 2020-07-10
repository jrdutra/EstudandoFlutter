import 'package:canarioterra/widgets/BarraAnimada.dart';
import 'package:canarioterra/widgets/Corpo.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Corpo(),
          BarraAnimada()
        ],
      )
    );
  }
}
