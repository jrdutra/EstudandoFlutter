import 'package:http/http.dart' as http;
import 'dart:convert';

const CHAVE_YOUTUBE_API = "AIzaSyASIjSPfP-p_0CEi1Qr52ceEMGvj96Xqyg";
const ID_CANAL = "UCj1AuxI-1Y-sK19nJEpcb3Q";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";



class Api {

  pesquisar(String pesquisa) async {

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

      if(response.statusCode == 200){

        print("Resultado: " + response.body);

      }else{

      }

  }

}