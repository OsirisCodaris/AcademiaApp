import 'package:academia26102020/form_log.dart';
import 'package:academia26102020/form_sign.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academia',
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green[900],
        accentColor: Colors.cyan[600],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                  child: Image(
                image: AssetImage('images/logo_academia.jpg'),
                width: 300,
                height: 300,
              )),
              new RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Connexion()));
                },
                color: Colors.green[900],
                child: new Text(
                  "Connexion",
                  style: new TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              new RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Inscription()));
                },
                color: Colors.green[800],
                child: new Text(
                  "Inscription",
                  style: new TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
