import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  Completer<GoogleMapController> _controler = Completer();
  Set<Marker> _marcadores = {};
  CameraPosition _posicaoCamera = CameraPosition(
      target: LatLng(-23.562436, -46.655005),
      zoom: 18
  );

  _onMapCreated(GoogleMapController controller){
      _controler.complete(controller);
  }

  _exibirMarcador(LatLng latLng) async{

    List<Placemark> listaEnderecos = await Geolocator().placemarkFromCoordinates(
        latLng.latitude, latLng.longitude
    );

    if(listaEnderecos !=null && listaEnderecos.length >0){

      Placemark endereco = listaEnderecos[0];
      String rua = endereco.thoroughfare;

      Marker marcador = Marker(
          markerId: MarkerId("marcador-${latLng.latitude}-${latLng.longitude}"),
          position: latLng,
          infoWindow: InfoWindow(
              title: rua
          )
      );

      setState(() {
        _marcadores.add(marcador);
      });

    }



  }

  _movimentarCamera() async{
    GoogleMapController googleMapController = await _controler.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        _posicaoCamera
      )
    );
  }

  _adicionarListenerLocalizacao(){
    var geolocator = Geolocator();
    var locationOption = LocationOptions(
      accuracy: LocationAccuracy.high
    );
    geolocator.getPositionStream(locationOption).listen((Position position) {
        setState(() {
          _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18
          );
          _movimentarCamera();
        });

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _adicionarListenerLocalizacao();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),
      body: Container(
        child: GoogleMap(
          markers: _marcadores,
          mapType: MapType.normal,
          initialCameraPosition: _posicaoCamera,
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador,
        ),
      ),
    );
  }
}
