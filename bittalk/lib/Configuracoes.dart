import 'package:bittalk/meusWidgets/GreenCircleAvatar.dart';
import 'package:bittalk/meusWidgets/GreenText.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  TextEditingController _controllerNome = TextEditingController();
  File _imagem;
  String _idUsuarioLogado;
  bool _subindoImagem = false;
  String _urlImagemRecuperada;

  Future _recuperarImagem(String origemImagem) async{

    File _imagemSelecionada;


    switch(origemImagem){
      case "camera":
        _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {

      _imagem = _imagemSelecionada;
      if( _imagem != null){
        _subindoImagem = true;
        _uploadImagem();
      }
    });

  }

  Future _uploadImagem() async{
      FirebaseStorage storage = FirebaseStorage.instance;
      StorageReference pastaRaiz = storage.ref();
      StorageReference arquivo = pastaRaiz
      .child("perfil")
      .child(_idUsuarioLogado + ".jpg");
      
      StorageUploadTask task = arquivo.putFile(_imagem);

      task.events.listen((StorageTaskEvent event) {

        if(event.type == StorageTaskEventType.progress){
            setState(() {
              _subindoImagem = true;
            });
        }else if(event.type == StorageTaskEventType.success){
          setState(() {
            _subindoImagem = false;
          });
        }

      });

      task.onComplete.then((StorageTaskSnapshot snapshot) {
        _recuperarUrlImagem(snapshot);
      });

  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async{
      String url = await snapshot.ref.getDownloadURL();
      _atualizarUrlImagemFireStore( url );
      setState(() {
        _urlImagemRecuperada = url;
      });
  }

  _atualizarUrlImagemFireStore(String url){

    Firestore db = Firestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "urlImagem" : url
    };

    db.collection("usuarios")
    .document(_idUsuarioLogado)
    .updateData(dadosAtualizar);

  }

  _atualizarNomeFireStore(String nome){
    //String nome = _controllerNome.text;
    Firestore db = Firestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "nome" : nome
    };

    db.collection("usuarios")
        .document(_idUsuarioLogado)
        .updateData(dadosAtualizar);

  }

  _recuperarDadosUsuario() async{
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseUser usuarioLogado = await auth.currentUser();
      _idUsuarioLogado = usuarioLogado.uid;

      Firestore db = Firestore.instance;
      DocumentSnapshot snapshot = await db.collection("usuarios")
      .document(_idUsuarioLogado)
      .get();

      Map<String, dynamic> dados = snapshot.data;
      _controllerNome.text = dados["nome"];

      if(dados["urlImagem"] != null){
        setState(() {
          _urlImagemRecuperada = dados["urlImagem"];
        });
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(color: Color(0xff00f004)),
          ),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Color(0xff00f004), //change your color here
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                   Container(
                     padding: EdgeInsets.all(16),
                     child: _subindoImagem
                         ? Padding(
                               padding: EdgeInsets.all(20),
                               child: CircularProgressIndicator(
                                   backgroundColor: Color(0xff00f004),
                                   strokeWidth: 2.0
                               ),
                             )
                         : Container()
                   ),
                   GreenCircleAvatar(
                    raio: 100,
                    caminho: _urlImagemRecuperada,
                  ),
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: GreenText("Camera"),
                        onPressed: (){
                          _recuperarImagem("camera");
                        },
                      ),
                      FlatButton(
                        child: GreenText("Gallery"),
                        onPressed: (){
                          _recuperarImagem("galeria");
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerNome,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff00f004),
                      ),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      onChanged: (texto){
                        _atualizarNomeFireStore(texto);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: RaisedButton(
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 20, color: Color(0xff00f004)),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Color(0xff00f004), width: 2)),
                      color: Colors.black,
                      padding: EdgeInsets.fromLTRB(32, 11, 32, 11),
                      onPressed: () {

                        _atualizarNomeFireStore(_controllerNome.text);

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
