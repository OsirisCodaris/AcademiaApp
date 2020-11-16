import 'package:academia26102020/Components/custom_snack.dart';
import 'package:academia26102020/HttpRequest/auth.dart';
import 'package:academia26102020/LocalRequest/localDatabase.dart';
import 'package:academia26102020/all_classe_subject.dart';
import 'package:academia26102020/all_subject.dart';
import 'package:academia26102020/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;

class Connexion extends StatefulWidget {
  ConnexionState createState() => new ConnexionState();
}

class ConnexionState extends State<Connexion> {
  String _UserIdentite;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Connexion'),
        centerTitle: true,
        elevation: 21.0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return new Center(
            child: SingleChildScrollView(
                child: new Column(
              children: <Widget>[
                new Container(
                    child: Image(
                  image: AssetImage('images/academia_log_sign.jpeg'),
                  width: 210,
                  height: 150,
                )),
                Container(
                  margin: EdgeInsets.all(12.0),
                  constraints: BoxConstraints.tight(const Size(300, 50)),
                  child: new TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "M@il ou Nom complet",
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (string) {
                      setState(() {
                        _UserIdentite = string;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(12.0),
                  constraints: BoxConstraints.tight(const Size(300, 50)),
                  child: new TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mot de passe",
                    ),
                    onChanged: (string) {
                      setState(() {
                        _password = string;
                      });
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if (_UserIdentite == null || _password == null) {
                      champVide(context);
                    } else {
                      connexionClick(context, _UserIdentite, _password);
                    }
                  },
                  child: new Text(
                    "Se connecter",
                  ),
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Container(
                          margin: EdgeInsets.only(right: 6.0),
                          child: FlatButton(
                            child: Text(
                              'Mot de passe oublié ?',
                              style: new TextStyle(fontSize: 12),
                            ),
                            padding: EdgeInsets.all(2),
                            textColor: Colors.red[400],
                            color: Colors.white,
                            onPressed: () {},
                          )),
                    ])
              ],
            )),
          );
        },
      ),
    );
  }

  Future<void> connexionClick(
      BuildContext context, String userIdentite, String password) async {
    String form =
        '{"fullname": "' + userIdentite + '","password": "' + password + '"}';

    var response = await Authentification.authentifier(form, 'login');

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      print(jsonResponse);

      //Création du user local
      var user = User(
        idusers: jsonResponse["idusers"],
        fullname: jsonResponse["fullname"],
        email: jsonResponse["email"],
        module: jsonResponse["module"],
        role: jsonResponse["role"],
        token: jsonResponse["token"],
        refreshToken: jsonResponse["refreshToken"],
      );

      //On va tester si il y'a un user dans la bdd local
      List<Map<String, dynamic>> queryRows =
          await DatabaseHelper.instance.user();

      print(queryRows);

      if (queryRows.length > 0) {
        //On delete le user existant pour enregistrer le nouveau
        int d = await DatabaseHelper.instance.deleteUser();

        if (d > 0) {
          print("il y'a un user il a bien été supprimé");
        } else {
          print("Aucun user trouvé");
        }

        //On enregistre le nouveau
        int i = await DatabaseHelper.instance.insertUser(user);

        if (i > 0) {
          print("nouveau user bien enregistré");
        } else {
          print("Erreur lors de l'enregistrement");
        }

        if (jsonResponse["role"] == "STUDENT") {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new AllSubject()));
        } else {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new AllClasseSubject()));
        }
      } else {
        //On enregistre le nouveau
        int i = await DatabaseHelper.instance.insertUser(user);

        if (jsonResponse["role"] == "STUDENT") {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new AllSubject()));
        } else {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new AllClasseSubject()));
        }
      }
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      Scaffold.of(context).showSnackBar(new SnackBar(
          content:
              new Text(jsonResponse['message'], textAlign: TextAlign.center)));
    }
  }

  void champVide(BuildContext context) {
    var custom =
        new CustomSnack("Veuillez remplir tous les champs !", "warning");
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: custom.getText(),
    ));
  }
}
