import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'b6e813dc745d66df1668f5b25da42ca4';

class NetworkHelper {

  NetworkHelper(this.url);

  String url;

  void getData() async {

    http.Response response = await http.get(url);

    if(response.statusCode == 200){
      String data = response.body;

      var decodedData = jsonDecode(data);

    }else{
      print(response.statusCode);
    }

  }


}