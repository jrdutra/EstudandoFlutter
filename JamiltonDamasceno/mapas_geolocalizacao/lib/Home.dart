import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};

  _onMapCreated(GoogleMapController googleMapController){
    _controller.complete( googleMapController);
  }

  _movimentarCamera() async{

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(-22.326128, -41.750137 ),
            zoom: 18,
            tilt: 16,
          bearing: 45
        ),
      )
    );
  }

  _carregarMarcadores(){

    Set<Marker> marcadoresLocal = {};

    Marker marcadorShopping = Marker(
      markerId: MarkerId("marcador-shopping"),
      position: LatLng(-22.335128, -41.749137 ),
      infoWindow: InfoWindow(
        title: "Casa"
      ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueMagenta
        ),
      rotation: 45,
        onTap: (){
        print("Casa clicada");
      }
    );
    Marker marcadorCartorio = Marker(
      markerId: MarkerId("marcador-shopping"),
      position: LatLng(-22.326128, -41.750137 ),
        infoWindow: InfoWindow(
            title: "UFRJ"
        )
    );
    marcadoresLocal.add(marcadorShopping);
    marcadoresLocal.add(marcadorCartorio);

    setState(() {
      _marcadores = marcadoresLocal;
    });

  }

  @override
  void initState() {
    _carregarMarcadores();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapas e geolocalização"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: _movimentarCamera,
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          //mapType: MapType.satellite,
          //-22.335128, -41.749137
          initialCameraPosition: CameraPosition(
            target: LatLng(-22.335128, -41.749137 ),
            zoom: 16
          ),
          onMapCreated: _onMapCreated,
          markers: _marcadores,
        ),
      ),
    );
  }
}
