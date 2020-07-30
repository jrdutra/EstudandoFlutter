import 'package:geolocator/geolocator.dart';

class Location {

  double latitude;
  double longitude;

  void getCurrentLoation() async{
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      this.longitude = position.longitude;
      this.latitude = position.latitude;
    }catch(e){
      print(e);
    }
  }

}