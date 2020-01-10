import 'dart:async';
import 'dart:convert' as json;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdm_app/PDMObject.dart';

class MyApp extends StatelessWidget {
  void main() => runApp(MyApp());

  get ()

  {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDM Reader',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'PDM Reader'),
    );
  }
}}

class Post {
  final String pbsNumber, name, frozen, itemType, buildType, qty, cadIssue, status, projectOwner, comment;

  var Posts = [];

  Post({this.pbsNumber, this.name, this.frozen, this.itemType, this.buildType, this.qty, this.cadIssue, this.status, this.projectOwner, this.comment});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      pbsNumber: json['feed']['entry'][2]['gsx\$_cn6ca']['\$t'],
      name: json['feed']['entry'][2]['gsx\$_cokwr']['\$t'],
      frozen: json['feed']['entry'][2]['gsx\$_cpzh4'],
      itemType: json['feed']['entry'][2]['gsx\$destinationdeepspace']['\$t'],
      buildType: json['feed']['entry'][2]['gsx\$_chk2m']['\$t'],
      qty: json['feed']['entry'][2]['gsx\$notescolumncandiareautomatedformulasdontmesswiththem']['\$t'],
      cadIssue: json['feed']['entry'][2]['gsx\$_ckd7g'],
      status: json['gsx\$_clrrx'],
      projectOwner: json['feed']['entry'][2]['gsx\$_cyevm'],
      comment: json['feed']['entry'][2]['gsx\$_cztg3']['\$t'],
    );


  }
}

Future<Post> fetchPost() async {
  final response =
  await http.get('https://spreadsheets.google.com/feeds/list/1GvAU02N6_spSQzg1hbaDnaMISZClsy7ZwwwaZ_5QrrA/1/public/values?alt=json');


  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> PDMObjects = [];

  Widget returnPDM(AsyncSnapshot<Post> snapshot){
    for(int i = 0; i < 500; i++){
      PDMObjects.add(PDMObject(
        pbsNumber: snapshot.data.pbsNumber,
        name: snapshot.data.name,
        frozen: snapshot.data.frozen,
        itemType: snapshot.data.itemType,
        buildType: snapshot.data.buildType,
        qty: snapshot.data.qty,
        cadIssue: snapshot.data.cadIssue,
        status: snapshot.data.status,
        projectOwner: snapshot.data.projectOwner,
        comment: snapshot.data.comment,
      ));
    }

    return ListView(
      children: PDMObjects,
    );
  }

  @override
  Widget build(BuildContext context) {

    fetchPost();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:FutureBuilder<Post>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return returnPDM(snapshot);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){fetchPost();},
        tooltip: 'Refresh',
        child: Icon(Icons.refresh, color: Colors.indigo),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
