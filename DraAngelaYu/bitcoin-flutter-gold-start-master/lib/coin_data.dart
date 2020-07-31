import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<List<Map<String, String>>> getCoinData(String selectedCurrency) async {
    List<Map<String, String>> listaRetorno = [];
    for(String cryptoCurrency in cryptoList){
      Map<String, String> item;
      String requestURL = '$coinAPIURL/$cryptoCurrency/$selectedCurrency/';
      http.Response response = await http.get(
          requestURL,
          headers: {'X-CoinAPI-Key': '$apiKey'},
      );
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        item = {cryptoCurrency: lastPrice};
      } else {
        print(response.statusCode);
        item = {cryptoCurrency: '?'};
      }
      listaRetorno.add(item);
    }
    return listaRetorno;
  }
}
