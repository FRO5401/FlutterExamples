import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  HomePageState createState()=> new HomePageState();


}

class HomePageState extends State<HomePage>{

  final String url = "https://swapi.co/api/people";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      //Encode the url
      Uri.encodeFull(url),
      //only accept json response
      headers: {"Accept": "application/json"}
    );

    print(response.body);

    setState((){
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });

    return "Success";
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar (
        title: new Text("Retrieve Json via HTTP Get"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/10,
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/12,
                      child: new Text(
                          data[index]['name'],
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width/30,
                          ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}