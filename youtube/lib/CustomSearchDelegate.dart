import 'package:flutter/material.dart';


class CustomSearchDelegate extends SearchDelegate<String> {

  //Botoões na barra de pesquisa a direita
  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        icon: Icon(
            Icons.clear,
        ),
        onPressed: (){
            query = "";
        },
      )
    ];
  }

  //Botao a direita da barra pesquisar (Voltar)
  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: (){
          close(context, "");
      },
    );
  }

  //Função que retorna a query após clicar na LUPA do teclado
  @override
  Widget buildResults(BuildContext context) {
    //print("Resultado: a pesquisa está sendo realizada");
    close(context, query);
    return Container();
  }

  //Parte das sugestões
  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> lista = List();

    if(query.isNotEmpty){

      lista = [
        "Android", "Android navegação", "IOS", "Jogos"
      ].where(
          (texto) => texto.toLowerCase().startsWith(query.toLowerCase())
      ).toList();

      return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (contex, index){
                  return ListTile(
                    onTap: (){
                      close(context, lista[index]);
                    },
                    title: Text(lista[index]),
                  );
                },
             );

    }else{
      return Center(
        child: Text("Nenhum resultado para a pesquisa"),
      );
    }

  }



}