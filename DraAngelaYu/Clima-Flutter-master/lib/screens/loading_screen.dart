import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;
  
  getLocationData() async{
    Location location = Location();
    await location.getCurrentLoation();
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper networkHelper = new NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=b6e813dc745d66df1668f5b25da42ca4');


    double temperature = decodedData['main']['temp'];
    int condition = decodedData['weather'][0]['id'];
    String cityName = decodedData['name'];

    print(temperature);
    print(condition);
    print(cityName );

  }


  @override
  void initState() {
    super.initState();
    getLocationData();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    );
  }
}
