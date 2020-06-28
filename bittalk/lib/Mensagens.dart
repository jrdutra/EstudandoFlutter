import 'package:bittalk/meusWidgets/GreenText.dart';
import 'package:bittalk/model/Usuario.dart';
import 'package:flutter/material.dart';

class Mensagens extends StatefulWidget {

  Usuario contato;

  Mensagens(this.contato);

  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {

  TextEditingController _controlerMensagem = TextEditingController();

  _enviarMensagem(){

  }

  enviarFoto(){

  }

  @override
  Widget build(BuildContext context) {

    List<String> listaMensagens = [
      "Mensagem 1",
      "Mensagem 2"
    ];

    var caixaMensagem = Container(
      padding: EdgeInsets.all(0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 2),
              child: TextField(
                controller: _controlerMensagem,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff00f004),
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                  hintText: "Digite uma mensagem...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: enviarFoto,
                  )
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            child: Icon(
                Icons.send,
                 color: Color(0xff00f004),
            ),
            mini: true,
            onPressed: _enviarMensagem,
          )
        ],
      ),
    );

    var listView = Expanded(
      child: ListView.builder(
        itemCount: listaMensagens.length,
        itemBuilder: (context, indice){

            Alignment alinhamento = Alignment.centerRight;
            TextStyle style = TextStyle(
              color: Colors.green,
            );
            if(indice % 2 == 0){

            }

            return Align(
              alignment: alinhamento,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: GreenText(
                      listaMensagens[indice],
                      style: style,
                  ),
                ),
              ),
            );
        },
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "\$ "+widget.contato.nome,
          style: TextStyle(color: Color(0xff00f004)),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Color(0xff00f004), //change your color here
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                listView,
                caixaMensagem
              ],
            ),
          ),
        ),
      ),
    );
  }
}
