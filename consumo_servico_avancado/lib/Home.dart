import 'package:consumoservicoavancado/Post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _urlBase = "https://jsonplaceholder.typicode.com";
  
  Future<List<Post>>_recuperarPostagens() async {
        http.Response response = await http.get(_urlBase + "/posts");
        var dadosJson = json.decode(response.body);
        List<Post> listaRetorno = new List();
        for( var post in dadosJson){
          Post p = new Post(post["userId"], post["id"], post["title"], post["body"]);
          listaRetorno.add(p);
        }
        return listaRetorno;
  }

  _post() async{

    var corpo = json.encode(
        {
          "userId": 120,
          "id": null,
          "title": "Título de teste",
          "body": "Corpo da postagem.."
        }
    );

    http.Response response = await http.post(
      _urlBase + "/posts",
      headers: {
           "Content-type": "application/json; charset=UTF-8",
      },
      body: corpo
    );
  }

  _put() async{

    var corpo = json.encode(
        {
          "userId": 120,
          "id": null,
          "title": "Título de teste",
          "body": "Corpo da postagem.."
        }
    );

    http.Response response = await http.put(
        _urlBase + "/posts/2",
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
        body: corpo
    );

    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");

  }

  _patch() async{

    var corpo = json.encode(
        {
          "userId": 120,
          "id": null,
          "body": "Corpo da postagem.."
        }
    );

    http.Response response = await http.put(
        _urlBase + "/posts/2",
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
        body: corpo
    );

    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");

  }

  _delete() async{

    http.Response response = await http.put(
        _urlBase + "/posts/2"
    );

    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado")
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Salvar"),
                  onPressed: _post,
                ),
                RaisedButton(
                  child: Text("Atualizar"),
                  onPressed: _patch,
                ),
                RaisedButton(
                  child: Text("Remover"),
                  onPressed: _delete,
                ),
              ],
            ),
            //Future
            Expanded(
             child: FutureBuilder<List<Post>>(
               future: _recuperarPostagens(),
               builder: (context, snapshot){
                 switch(snapshot.connectionState){
                   case ConnectionState.none:
                   case ConnectionState.waiting:
                     return Center(
                       child: CircularProgressIndicator(),
                     );
                     break;
                   case ConnectionState.active:
                   case ConnectionState.done:
                     if( snapshot.hasError ){
                       return Text("Erro!");
                     }else{
                       return ListView.builder(
                           itemCount: snapshot.data.length,
                           itemBuilder: (context, index){
                             List<Post> lista = snapshot.data;
                             Post post = lista[index];
                             return ListTile(
                                 title: Text(post.title),
                                 subtitle: Text(post.id.toString())
                             );
                           }
                       );
                     }
                     break;
                 }
                 return null;
               },
             ),
            )
          ],
        ),
      )
    );
  }
}
