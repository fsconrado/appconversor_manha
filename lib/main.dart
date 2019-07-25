import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const requisicao =
    "https://api.hgbrasil.com/finance?format=json-cors&key=4bb3f02a";

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

Future<Map> getDados() async {
  http.Response response = await http.get(requisicao);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: getDados(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: Text(
                    "Carregando os Dados....",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  ),
                );
              default:
                if(snapshot.hasError){
                  return Center(
                    child: Text(
                      "Erro ao Carregar os Dados :'(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Deu Certoooooo :)!!!",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    ),
                  );
                }

            }
          }),
    );
  }
}
