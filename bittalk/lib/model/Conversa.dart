import 'package:cloud_firestore/cloud_firestore.dart';

class Conversa {
  String _idRemetente;
  String _idDestinatario;
  String _nome;
  String _mensagem;
  String _caminhoFoto;
  String _tipoMensagem;
  Timestamp _dataHora;

  Conversa();


  Conversa.nova(this._idRemetente, this._idDestinatario, this._nome, this._mensagem,
      this._caminhoFoto, this._tipoMensagem, this._dataHora);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idRemetente": this.idRemetente,
      "idDestinatario": this.idDestinatario,
      "nome": this.nome,
      "mensagem": this.mensagem,
      "caminhoFoto": this.caminhoFoto,
      "tipoMensagem": this.tipoMensagem,
      "dataHora": this.dataHora
    };
    return map;
  }

  salvar() async {
    Firestore db = Firestore.instance;
    await db
        .collection("conversas")
        .document(this.idRemetente)
        .collection("ultima_conversa")
        .document(this.idDestinatario)
        .setData(this.toMap());
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get mensagem => _mensagem;

  String get caminhoFoto => _caminhoFoto;

  set caminhoFoto(String value) {
    _caminhoFoto = value;
  }

  set mensagem(String value) {
    _mensagem = value;
  }

  String get tipoMensagem => _tipoMensagem;

  set tipoMensagem(String value) {
    _tipoMensagem = value;
  }

  String get idDestinatario => _idDestinatario;

  set idDestinatario(String value) {
    _idDestinatario = value;
  }

  String get idRemetente => _idRemetente;

  set idRemetente(String value) {
    _idRemetente = value;
  }


  Timestamp get dataHora => _dataHora;

  set dataHora(Timestamp value) {
    _dataHora = value;
  }

  @override
  String toString() {
    return 'Conversa{_idRemetente: $_idRemetente, _idDestinatario: $_idDestinatario, _nome: $_nome, _mensagem: $_mensagem}';
  }

}
