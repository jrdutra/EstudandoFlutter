import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //=============================
  // LENDO E ESCREVENDO NO BANCO
  //=============================
  //Firestore db = Firestore.instance;
  /*
  db.collection("usuarios")
    .document("002")
    .setData(
      {
        "nome": "Ana Maria",
        "idade": "25"
      }
  );*/
  /*
  DocumentReference ref = await db.collection("noticias")
  .add(
      {
        "Titulo": "Ondas de Calor em São Paulo",
        "idade": "Texto de exemplo..."
      }
  );*/

  //print("Item salvo: "+ ref.documentID);
  /*
  db.collection("noticias")
  .document("9ZAJY2ocDYeefA1Kc7Zt")
  .setData(
      {
        "Titulo": "Ondas de Calor em São Paulo Alterado",
        "idade": "Texto de exemplo..."
      }
  );

  //db.collection("usuarios").document("003").delete();

  DocumentSnapshot snapshot = await db.collection("usuarios").document("001").get();
  print("dados: " + snapshot.data.toString());
  */

//  QuerySnapshot querySnapshot = await db.collection("usuarios").getDocuments();

  //print("dados usuarios: " + querySnapshot.documents.toString());
/*
  for(DocumentSnapshot item in querySnapshot.documents){
    var dados = item.data;
    print("dados usuarios: " + dados.toString());
  }*/
  /*
  db.collection("usuarios")
      .snapshots()
      .listen(
          (snapshot) {
            for(DocumentSnapshot item in snapshot.documents){
              var dados = item.data;
              print("dados usuarios: " + dados.toString());
            }
          }
  );*/
  /*
  var pesquisa = "an";
  QuerySnapshot querySnapshot = await db.collection("usuarios")
  //.where("nome", isEqualTo: "jamilton").
  //.where("idade", isGreaterThan: 28)
  //.orderBy("idade", descending: true)
  //.orderBy("nome", descending: false)
  //.limit(2)
  .where("nome", isGreaterThanOrEqualTo: pesquisa)
  .where("nome", isLessThanOrEqualTo: pesquisa + "\uf8ff")
  .getDocuments();

  for(DocumentSnapshot item in querySnapshot.documents){
      var dados = item.data;
      print("DADOS: " + dados.toString());
  }*/

  //======================
  //LOGIN DE USUARIOS
  //======================

  //FirebaseAuth auth = FirebaseAuth.instance;
  //String email = "jrdutra.com.br@gmail.com";
  //String senha = "Jrdutra1";

  /*auth.createUserWithEmailAndPassword(
      email: email, 
      password: senha
  ).then((firebaseUser) {
    print("Novo usuario: Sucesso!! e-mail: " + firebaseUser.email);
  }).catchError((erro){
    print("Novo usuario: erro: " + erro.toString());
  });*/

  //auth.signOut();
  /*
  auth.signInWithEmailAndPassword(
      email: email,
      password: senha).then((firebaseUser) {
    print("Logado usuario: Sucesso!! e-mail: " + firebaseUser.email);
  }).catchError((erro){
    print("Novo usuario: erro: " + erro.toString());
  });

  FirebaseUser usuarioAtual = await auth.currentUser();
  if(usuarioAtual != null){
    print("Usuario logado email:" + usuarioAtual.email);
  }else{
    print("Usuario deslogado.");
  }*/

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File _imagem;
  String _statusUpload = "Upload nao iniciado...";
  String _urlRecuperada = null;

  Future _arecuperarImagem(bool daCamera) async{

    File _imagemSelecionada;

    if(daCamera){
      _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{
      _imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = _imagemSelecionada;
    });

  }

  Future _uploadImagem(){
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz.child("fotos").child("fotos.jpg");
    StorageUploadTask task = arquivo.putFile(_imagem);

    task.events.listen((StorageTaskEvent storageEvent){

          if(storageEvent.type == StorageTaskEventType.progress){
            setState(() {
              _statusUpload = "Em progresso";
            });
          }else if(storageEvent.type == StorageTaskEventType.success){
            setState(() {
              _statusUpload = "Upload realizado com sucesso!";
            });
          }
    });

    task.onComplete.then((StorageTaskSnapshot snapshot){
        _recuperarUrlImagem(snapshot);
    });

  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async{
      String url = await snapshot.ref.getDownloadURL();

      print("URL: "+url);

      setState(() {
        _urlRecuperada = url;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carregando imagens"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(_statusUpload),
            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _arecuperarImagem(true);
              },
            ),
            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _arecuperarImagem(false);
              },
            ),
            _imagem == null ?
            Container() :
            Image.file(_imagem),
            RaisedButton(
              child: Text("Upload Storage"),
              onPressed: (){
                _uploadImagem();
              },
            ),
            _urlRecuperada == null ?
                Container() :
                Image.network(_urlRecuperada)
          ],
        ),
      )
    );
  }
}
