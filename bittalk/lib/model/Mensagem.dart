class Mensagem {

  String _idUsuario;
  String _mensagem;
  String _urlImagem;
  String _tipo;
  DateTime _dataHora;


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


  DateTime get dataHora => _dataHora;

  set dataHora(DateTime value) {
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