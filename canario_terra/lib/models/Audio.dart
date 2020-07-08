import 'dart:math';

class Audio {

  static List<Map<String, String>> _listaAudios =
  [
    {
      "textoAudio": "Carretilha",
      "caminhoAudio": "Carretilha.mp3"
    },
    {
      "textoAudio": "Estalo",
      "caminhoAudio": "Estalo.mp3"
    },
    {
      "textoAudio": "Estalo-Canto-Longo",
      "caminhoAudio": "Estalo-Canto-Longo.mp3"
    },
    {
      "textoAudio": "Estalo-com-Carretilha",
      "caminhoAudio": "Estalo-com-Carretilha.mp3"
    },
    {
      "textoAudio": "Fêmea",
      "caminhoAudio": "femeaP.mp3"
    },
    {
      "textoAudio": "Macho e Fêmea (Esquenta)",
      "caminhoAudio": "machoEFemea.mp3"
    },
    {
      "textoAudio": "Metralha de 1 Nota",
      "caminhoAudio": "Metralha-1-Nota.mp3"
    },
    {
      "textoAudio": "Metralha de 2 Notas",
      "caminhoAudio": "Metralha-2-Notas.mp3"
    },
    {
      "textoAudio": "Paulistinha",
      "caminhoAudio": "paulistinha.mp3"
    },
    {
      "textoAudio": "Retinido",
      "caminhoAudio": "Retinido.mp3"
    }
  ];


  Audio();

  List<Map<String, String>> get listaAudios => _listaAudios;

  set listaAudios(List<Map<String, String>> value) {
    _listaAudios = value;
  }

  static Map<String, String> getAudioAleatorio(){
    var index = Random().nextInt(_listaAudios.length);
    return _listaAudios[index];
  }

  static Map<String, String> getAudioIndice(var index){
    return _listaAudios[index];
  }

  static int getAudioTamanho(){
    return _listaAudios.length;
  }

  static List<Map<String, String>> getListaAudio(){
    return _listaAudios;
  }


}
