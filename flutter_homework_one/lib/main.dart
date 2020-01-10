import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(


        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder> {
        SecondPage.routeName: (context) => new SecondPage()
      },
    );
  }
}

var kColour = Colors.blue;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // ignore: non_constant_identifier_names

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String sharedString;
  @override
  void initState() {
    getStringPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('The Best Home Page Ever'),
        ),

        drawer: Drawer (
          child: ListView(
            children: <Widget>[

              Container (
                width: MediaQuery.of(context).size.width/7,
                height: MediaQuery.of(context).size.width/7,
                color: Colors.white,
                child: Card (
                  color: Colors.lightBlue,
                  child: ListTile (
                    title: Text (
                        "Random Page 1",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: MediaQuery.of(context).size.width/22,
                        ),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RandomPageUno()),
                      );
                    }
                  ),
                ),
              ),
               Container (
                 width: MediaQuery.of(context).size.width/7,
                 height: MediaQuery.of(context).size.width/7,
                 color: Colors.white,
                child: Card (
                  color: Colors.lightBlue,
                  child: ListTile(
                    title: Text(
                        "Random Page 2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width/22,
                        ),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RandomPageDos()),
                        );
                      },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
          widthFactor: MediaQuery.of(context).size.width,
          heightFactor: MediaQuery.of(context).size.height,


            child: Container (
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Save, Encode, and Open Results'),
                      onPressed: () {
                        saveString (

                        );

                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      height: MediaQuery.of(context).size.height/1.5,
                      child: TextField(
                        controller: returnShared(),
                        keyboardType:  TextInputType.multiline,
                        onChanged:(String value){
                          sharedString = value;
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



                    ),

                  ],
                )
            ),

            // This trailing comma makes auto-formatting nicer for build methods.
          ),

    );
  }


  returnShared(){
    if(sharedString != null){
      return TextEditingController(text: "$sharedString");
    } else if(sharedString == null){
      return TextEditingController(text: null);
    }
  }

  void saveString() {
    String string = sharedString;
    saveStringPreference(string).then((bool committed) {
      Navigator.of(context).pushNamed(SecondPage.routeName);
    });
  }

  Future<String> getStringPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String string = prefs.getString("name");
    sharedString = string;
    return string;
  }
}

Future<bool> saveStringPreference(String string) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", string);

  return prefs.commit();
}

Future<String> getStringPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String string = prefs.getString("name");



  return string;
}

class SecondPage extends StatefulWidget {
  static String routeName = "/nextPage";

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String _string = "";
  String _encode = "";
  String _decode = "";


  @override
  void initState() {
    getStringPreference().then(updateString);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Results Page Yo'),
        ),
        body: Center(
          child: new Center(

            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.


            child: Container (
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Card (
                      color: Colors.white,
                      child: Text(
                         "This is the Regular String: " + _string,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width/ 25,
                            color: Colors.black
                          )
                      ),
                    ),
                    Card (
                      color: Colors.white,
                      child: Text(
                        "This is the Encoded String: " + _encode,
                          style: TextStyle(
                            fontSize:MediaQuery.of(context).size.width / 25,
                            color: Colors.red[900],
                          ),
                      ),
                    ),
                    Card (
                      color: Colors.white,
                      child: Text(
                        "This is the Decoded String: " + _decode,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 25,
                            color: Colors.blue[900],
                        ),
                      ),
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red[900],
                      child: Text('Frick, go back'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container (
                      width: MediaQuery.of(context).size.width/1.5,
                      height: MediaQuery.of(context).size.height/3,
                      child: TextField(
                        keyboardType:  TextInputType.multiline,
                        maxLines: 7,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 25,
                          color: Colors.white
                      ),

                        decoration: InputDecoration( //creates an InputDecoration with a border that remains constantly.
                          fillColor: Colors.grey,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: MediaQuery.of(context).size.width / 100, color: kColour),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: MediaQuery.of(context).size.width / 100, color: kColour),
                          ),
                          hintText: 'This Text Box is for the aesthetic',
                        ),

                      ),
                    ),
                  ],
                )
            ),

            // This trailing comma makes auto-formatting nicer for build methods.
          ),
        )
    );

  }

  void updateString(String string) {
    setState(() {
      this._string = string;
      this._encode = base64.encode(utf8.encode(string));
      this._decode = utf8.decode(base64.decode(_encode));
    });
  }
}


class RandomPageUno extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar(
        title: Text("I'll use this eventually")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text("Home Button"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );

  }

}

class RandomPageDos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar(
          title: Text("I'll use this at some point")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text("Home Button"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

    );

  }

}