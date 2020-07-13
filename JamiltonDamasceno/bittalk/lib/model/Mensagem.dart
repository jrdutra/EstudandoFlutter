import 'package:cloud_firestore/cloud_firestore.dart';

class Mensagem {

  String _idUsuario;
  String _mensagem;
  String _urlImagem;
  String _tipo;
  Timestamp _dataHora;


  Mensagem();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUsuario" : this.idUsuario,
      "mensagem": this.mensagem,
      "urlImagem": this.urlImagem,
      "tipo": this.tipo,
      "dataHora": this.dataHora
    };
    return map;
  }


  Timestamp get dataHora => _dataHora;

  set dataHora(Timestamp value) {
    _dataHora = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get urlImagem => _urlImagem;

  set urlImagem(String value) {
    _urlImagem = value;
  }

  String get mensagem => _mensagem;

  set mensagem(String value) {
    _mensagem = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }


}