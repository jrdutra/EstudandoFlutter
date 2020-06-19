import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Firestore db = Firestore.instance;
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

  db.collection("usuarios")
      .snapshots()
      .listen(
          (snapshot) {
            for(DocumentSnapshot item in snapshot.documents){
              var dados = item.data;
              print("dados usuarios: " + dados.toString());
            }
          }
  );

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
