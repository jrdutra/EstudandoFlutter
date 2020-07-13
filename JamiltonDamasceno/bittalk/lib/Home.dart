import 'package:bittalk/Login.dart';
import 'package:bittalk/meusWidgets/GreenText.dart';
import 'package:bittalk/telas/AbaContatos.dart';
import 'package:bittalk/telas/AbaConversas.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _itensMenu = ["Settings", "Logout"];
  String _emailUsuarioLogado = "";
  String _totalContatos = "0";

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

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: 'ca-app-pub-5851652075835518/1132521299',
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  BannerAd _bannerAd;

  _iniciaIntersticial() {
    myInterstitial
      ..load()
      ..show(
          anchorType: AnchorType.bottom,
          anchorOffset: 0.0,
          horizontalCenterOffset: 0.0);
  }

  //--------
  //FIM ADMOB
  //--------

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuarioLogado = usuarioLogado.email;
    });
  }

  Future _verificaUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    if (usuarioLogado == null) {
      Navigator.pushReplacementNamed(context, "/login");
    }else{
      _recuperaTotalContatos();
    }
  }

  @override
  void initState() {
    //ADMOB
    //FirebaseAdMob.instance.initialize(
    //appId: 'ca-app-pub-5851652075835518~3042059836'
    //);
    //_bannerAd = myBanner..load()..show(anchorType: AnchorType.bottom);
    _iniciaIntersticial();
    //FIM ADDMOB
    super.initState();
    _verificaUsuarioLogado();
    _recuperarDadosUsuario();
    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  void dispose() {
    //_bannerAd.dispose();
    //myInterstitial.dispose();
    super.dispose();
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/login");
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Settings":
        Navigator.pushNamed(context, "/configuracoes");
        break;
      case "Logout":
        _deslogarUsuario();
        break;
    }
  }

  _recuperaTotalContatos() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot =
        await db.collection("usuarios").getDocuments();

    String totalContatos = (querySnapshot.documents.length-1).toString();

      setState(() {
        _totalContatos = totalContatos;
      });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff00f004), //change your color here
        ),
        title: GreenText("bitTalk"),
        backgroundColor: Colors.black,
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff00f004)),
          controller: _tabController,
          indicatorColor: Color(0xff00f004),
          labelColor: Color(0xff00f004),
          tabs: <Widget>[
            Tab(
              text: "Chat",
            ),
            Tab(
              text: "Users($_totalContatos)",
            )
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.black,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xff00f004), width: 3)),
            icon: Image.asset(
              "assets/images/menu-icon.png",
              width: 29,
            ),
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return _itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: GreenText(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[AbaConversas(), AbaContatos()],
      ),
    );
  }
}
