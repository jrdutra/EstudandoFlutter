import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<dynamic> _listaTarefas = [];
  TextEditingController _controllerTarefa = TextEditingController();

  Future<File>_getFile() async{
    final diretorio = await getApplicationDocumentsDirectory();
    var arquivo = File( "${diretorio.path}/dados.json" );
    return arquivo;
  }

  _salvarArquivo() async{
    var arquivo = await _getFile();
    String dados = json.encode( _listaTarefas );
    arquivo.writeAsString( dados );
  }

  _salvarTarefa(){
    String textoDigitado = _controllerTarefa.text;
    //Criar dados
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;
    setState(() {
      _listaTarefas.add( tarefa );
    });
    _salvarArquivo();
    _controllerTarefa.text = "";
  }

  _lerArquivo() async {
    try{
      final arquivo = await _getFile();
      return arquivo.readAsString();
    }catch(e){
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lerArquivo().then((daods){
      setState(() {
        _listaTarefas = json.decode(daods);
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    //_salvarArquivo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Lista de tarefas"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Adicionar tarefa"),
                    content: TextField(
                      controller: _controllerTarefa,
                      decoration: InputDecoration(
                        labelText: "Digite sua tarefa"
                      ),
                      onChanged: (texto){

                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Cancelar"),
                        onPressed: () => Navigator.pop(context),

                      ),
                      FlatButton(
                        child: Text("Salvar"),
                        onPressed: (){
                          //salvar
                          _salvarTarefa();
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
              }
            );
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _listaTarefas.length,
                itemBuilder: (context, index){
                  return CheckboxListTile(
                    title: Text(_listaTarefas[index]['titulo']),
                    value: _listaTarefas[index]['realizada'],
                    activeColor: Colors.purple,
                    checkColor: Colors.white,
                    onChanged: (valorAlterado){
                      setState(() {
                        _listaTarefas[index]['realizada'] = valorAlterado;
                      });
                      _salvarArquivo();
                    },
                  );
                  /*
                  return ListTile(
                    title: Text(_listaTarefas[index]['titulo']),
                  );*/
                }
            ),
          )
        ],
      ),
    );
  }
}
