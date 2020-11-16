import 'package:academia26102020/Components/custom_snack.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';


class Profil extends StatefulWidget{
  ProfilState createState() => new ProfilState();
}

class ProfilState extends State<Profil>{

  String _nomComplet;
  String _phone;
  String _email;
  String _password;
  String _confirmePassword;
  String _btnModification = 'Activer modification';

  bool _showPassword = false;
  bool _showConfPassword = false;
  bool _modifierProfile = false;

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text('Mon Profil'),
          centerTitle: false,

            actions: <Widget>[
        Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.more_vert,
                  ),
                )
            ),
            ]

        ),

        body: Builder(
          builder: (BuildContext context){
            return new Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _keyForm,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                            child: Image(
                              image: AssetImage('images/academia_log_sign.jpeg'),
                              width: 120,
                              height: 120,
                            )
                        ),

                        Container(
                          margin: EdgeInsets.all(12.0),
                          child:
                          new TextFormField(
                            readOnly: !this._modifierProfile,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Ecrire votre Nom et Prénom",
                              prefixIcon: Icon(Icons.perm_identity),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (val) => val.isEmpty ? 'Le nom complet ne peut être vide' : null,
                            onChanged: (val) => _nomComplet = val,
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(12.0),
                          child:
                          new TextFormField(
                            readOnly: !this._modifierProfile,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Ecrire votre numéro de téléphone",
                              prefixIcon: Icon(Icons.phone_android),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) => val.isEmpty ? 'Vous devez entrer un numéro de téléphone' : null,
                            onChanged: (val) => _phone = val,
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(12.0),
                          child:
                          new TextFormField(
                            readOnly: !this._modifierProfile,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Ecrire votre adresse m@il",
                              prefixIcon: Icon(Icons.mail_outline),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) =>  EmailValidator.validate(_email) != true ? 'Mail invalide' : null,
                            onChanged: (val) => _email = val,

                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(12.0),
                          child:
                          new TextFormField(
                            readOnly: !this._modifierProfile,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Ecrire un mot de passe",
                              prefixIcon: Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  this._showPassword ? Icons.remove_red_eye : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() => this._showPassword = !this._showPassword);
                                },
                              ),
                            ),
                            obscureText: !this._showPassword,
                            validator: (val) => val.length<8 ? 'Minimum 8 caractères pour le Mot de passe' : null,
                            onChanged: (val) => _password = val,

                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(12.0),
                          child:
                          new TextFormField(
                            readOnly: !this._modifierProfile,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Confirmer le mot de passe",
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  this._showConfPassword ? Icons.remove_red_eye : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() => this._showConfPassword = !this._showConfPassword);
                                },
                              ),
                            ),
                            obscureText: !this._showConfPassword,
                            onChanged: (val) => _confirmePassword = val,
                            validator: (val) => _confirmePassword != _password ? 'Confirmation incorrecte' : null,

                          ),
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children : <Widget>[

                              OutlineButton(

                                child: Text(
                                  '$_btnModification',
                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () {
                                  setState((){
                                    this._modifierProfile = !this._modifierProfile;
                                    this._modifierProfile ? this._btnModification ='Désactiver modification' : this._btnModification ='Activer modification';
                                  });
                                },
                              ),
                              new Container(
                                child: new RaisedButton(
                                  padding: EdgeInsets.only(right: 0, left: 12),
                                  onPressed: (){

                                    if(_keyForm.currentState.validate()){
                                      print('Infos Modifiées');
                                    }
                                  },
                                  child: Row( // Replace with a Row for horizontal icon + text
                                    children: <Widget>[
                                      Text( "Valider",
                                        style: new TextStyle(
                                            fontSize: 12.0),
                                      ),
                                      Icon(Icons.check_circle, color: Colors.yellow,),
                                    ],
                                  ),
                                ),
                              )
                            ]
                        ),

                      ],
                    ),
                  ),

                )
            );
          },
        )
    );
  }

}