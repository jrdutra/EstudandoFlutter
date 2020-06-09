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

  //Botao a direita da barra pesquisar
  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: (){
          close(context, null);
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

  @override
  Widget buildSuggestions(BuildContext context) {
    //print("resultado: digitado " + query);
    return Container();
  }



}