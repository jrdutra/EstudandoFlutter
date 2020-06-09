import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyASIjSPfP-p_0CEi1Qr52ceEMGvj96Xqyg";
const ID_CANAL = "UCj1AuxI-1Y-sK19nJEpcb3Q";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";



class Api {

  Future<List<Video>> pesquisar(String pesquisa) async {

      http.Response response = await http.get(
          URL_BASE + "search"
              "?part=snippet"
              "&type=video"
              "&maxResults=20"
              "&order=date"
              "&key=$CHAVE_YOUTUBE_API"
              "&channelId=$ID_CANAL"
              "&q=$pesquisa"
      );

      print("URL:" + URL_BASE + "search"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$CHAVE_YOUTUBE_API"
          "&channelId=$ID_CANAL"
          "&q=$pesquisa");

      if(response.statusCode == 200){
        Map<String, dynamic> dadosJson = json.decode(response.body);
        List<Video> videos = dadosJson["items"].map<Video>(
            (map){
              return Video.fromJson(map);
            }
        ).toList();

        print("Videos"+videos.toString());
        return videos;
      }else{

      }
  }
}