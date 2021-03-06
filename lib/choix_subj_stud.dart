import 'package:academia26102020/Components/custom_snack.dart';
import 'package:academia26102020/HttpRequest/auth.dart';
import 'package:flutter/material.dart';
import 'HttpRequest/classe.dart';
import 'dart:convert' as convert;

import 'form_log.dart';

class InscriptionStud extends StatefulWidget {
  String nomComplet;
  String phone;
  String email;
  String password;

  InscriptionStud(this.nomComplet, this.phone, this.email, this.password);

  InscriptionStudState createState() => new InscriptionStudState(
      this.nomComplet, this.phone, this.email, this.password);
}

class InscriptionStudState extends State<InscriptionStud> {
  String nomComplet;
  String phone;
  String email;
  String password;
  List<Classes> classes;
  Classes selectedClasse = null;
  bool isLoading = true;

  InscriptionStudState(this.nomComplet, this.phone, this.email, this.password);

  @override
  initState() {
    super.initState();
    onLoad();
  }

  onLoad() async {
    classes = await Classes.getClasses();
    setState(() {
      isLoading = false;
    });
    print(classes);
  }

  List<Widget> createRadioListClasses() {
    List<Widget> widgets = [];
    for (Classes classe in classes) {
      widgets.add(
        RadioListTile(
          value: classe,
          groupValue: selectedClasse,
          title: Text(classe.name),
          onChanged: (currentClasse) {
            setSelectedClasse(currentClasse);
          },
          selected: selectedClasse == classe,
        ),
      );
    }

    return widgets;
  }

  setSelectedClasse(Classes classe) {
    setState(() {
      selectedClasse = classe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Inscription 3/3'),
        centerTitle: true,
        elevation: 21.0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return new Center(
              child: SingleChildScrollView(
            child: isLoading
                ? new Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        padding: new EdgeInsets.all(9.0),
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xff5F8463),
                          strokeWidth: 3.0,
                        ),
                      )
                    ],
                  ))
                : new Column(
                    children: <Widget>[
                      const Text.rich(
                        TextSpan(
                          style:
                              TextStyle(fontSize: 21, color: Color(0xff5F8463)),
                          text: 'Vous êtes', // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text: ' élève',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Divider(),
                      const Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          text: 'Choisissez votre', // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text: ' classe',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      new Card(
                          color: Color(0xff5F8463),
                          margin: EdgeInsets.all(12.0),
                          child: new Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 3.0),
                            child: Column(
                              children: createRadioListClasses(),
                            ),
                          )),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Container(
                            child: RaisedButton(
                              onPressed: () {
                                if (selectedClasse == null) {
                                  erreurSelection(context);
                                } else {
                                  enregistreUser(context, nomComplet, phone,
                                      email, password, selectedClasse);
                                }
                              },
                              padding: EdgeInsets.only(right: 0, left: 6),
                              child: Row(
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Text(
                                    "Finir ",
                                    style: new TextStyle(fontSize: 15.0),
                                  ),
                                  Icon(Icons.check_circle,
                                      color: Colors.yellow, size: 21),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
          ));
        },
      ),
    );
  }

  void erreurSelection(BuildContext context) {
    var custom = new CustomSnack("Veuillez choisir une classe !", "warning");
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: custom.getText(),
    ));
  }

  Future<void> enregistreUser(
      BuildContext context,
      String nomComplet,
      String phone,
      String email,
      String password,
      Classes selectedClasse) async {
    String form = '{"user":{"fullname": "' +
        nomComplet +
        '","phone":"' +
        phone +
        '","email": "' +
        email +
        '","password": "' +
        password +
        '"},"student":{"idclasses":"' +
        selectedClasse.idclasses.toString() +
        '"}}';
    print(form);
    var response = await Authentification.register(form, 'students');
    if (response.statusCode == 201) {
      var custom = new CustomSnack("Inscription validée", "success");
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: custom.getText(),
      ));
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new Connexion()));
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      Scaffold.of(context).showSnackBar(new SnackBar(
          content:
              new Text(jsonResponse['error'], textAlign: TextAlign.center)));
    }
  }
}
