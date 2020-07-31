import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '73230758-CC7E-4151-B2DF-67D8EDC862AB';

class CoinData {

  CoinData({this.url});

  String url;

  void getCoinData() async {
      http.Response response = await http.get(
          '$coinAPIURL/BTC/USD/',
          headers: {'X-CoinAPI-Key': '$apiKey'},
      );
      if(response.statusCode == 200){
        String data = response.body;
        print(jsonDecode(data));
        return jsonDecode(data);
      }else{
        print(response.statusCode);
      }
  }

}
