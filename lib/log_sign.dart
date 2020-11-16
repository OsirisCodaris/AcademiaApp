import 'package:academia26102020/form_log.dart';
import 'package:academia26102020/form_sign.dart';
import 'package:flutter/material.dart';

class ChoixLog extends StatefulWidget {
  ChoixLogState createState() => new ChoixLogState();
}

class ChoixLogState extends State<ChoixLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                  margin: EdgeInsets.only(bottom: 36.0, left: 6.0),
                  child: Image(
                    image: AssetImage('images/academia_log_sign.jpeg'),
                  )),
              new RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Connexion()));
                },
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
