import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      title: 'File Test',
      home: HomePage(storage: Storage()),
    ),
  );
}

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/string.txt');
  }

  Future<String> readInput() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return " ";
    }
  }

  Future<File> writeString(String string) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$string');
  }
}

var kColour = Colors.blue;

class HomePage extends StatefulWidget {
  final Storage storage;

  HomePage({Key key, @required this.storage}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _thing;

  @override
  void initState() {
    super.initState();
    widget.storage.readInput().then((String value) {
      setState(() {
        _thing = value;
      });
    });
  }



    // Write the variable as a string to the file.



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(
        child: Column(
        children: <Widget> [
          TextField(
            controller: returnString(),
        keyboardType:  TextInputType.multiline,
        onChanged:(String value){
          _thing = value;
        },



        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 25,
            color: Colors.white

        ),
        maxLines: 10,
        decoration: InputDecoration( //creates an InputDecoration with a border that remains constantly.
          fillColor: Colors.grey,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: MediaQuery.of(context).size.width / 100, color: kColour),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: MediaQuery.of(context).size.width / 100, color: kColour),
          ),
            hintText: 'Please write something because I am lonely....',
            ),
          ),

          Text(
            'What you typed: ' + _thing,
          ),
           RaisedButton(
             child: Text('Save'),
             onPressed: () {
               return widget.storage.writeString(_thing);
             }
           ),
          RaisedButton(
            child: Text('Go to the Second Page'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
          ),
        ],
      ),
      ),
    );
  }
  returnString(){
    if(_thing != null){
      return TextEditingController(text: "$_thing");
    } else if(_thing == null){
      return TextEditingController(text: null);
    }

  }
}

class SecondPage extends StatefulWidget {
  @override
  State createState() => new SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  String _base64;

  @override
  void initState() {
    super.initState();
    (() async {
      http.Response response = await http.get(
        'https://i2.wp.com/team5401.org/wp-content/uploads/2017/02/cropped-cropped-cropped-Header2-2.png?fit=512%2C512',
      );
      if (mounted) {
        setState(() {
          _base64 = base64.encode(response.bodyBytes);
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    if (_base64 == null)
      return new Container();
    Uint8List bytes = base64.decode(_base64);
    return new Scaffold(
      appBar: new AppBar(title: new Text('Example App')),
      body: Container (
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height  ,
        child: Image.memory(bytes),
      ),
    );
  }
}