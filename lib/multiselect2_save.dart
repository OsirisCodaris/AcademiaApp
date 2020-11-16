import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'HttpRequest/auth.dart';
import 'HttpRequest/matiere.dart';
import 'form_log.dart';
import 'dart:convert' as convert;

class InscriptionProf extends StatefulWidget {
  String nomComplet;
  String phone;
  String email;
  String password;

  InscriptionProf(this.nomComplet, this.phone, this.email, this.password);

  InscriptionProfState createState() => new InscriptionProfState(
      this.nomComplet, this.phone, this.email, this.password);
}

class InscriptionProfState extends State<InscriptionProf> {
  String nomComplet;
  String phone;
  String email;
  String password;
  String phone2;

  List<Matieres> matieres;
  bool isLoading = true;

  Matieres selectedMatiere = null;

  String selectedVille = 'Libreville';

  final _formKey = GlobalKey<FormState>();

  List _myActivities;
  String _myActivitiesResult;

  InscriptionProfState(this.nomComplet, this.phone, this.email, this.password);

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
    onLoad();
  }

  onLoad() async {
    matieres = await Matieres.getMatiere();
    setState(() {
      isLoading = false;
    });
    print(matieres);
  }

  setSelectedClasse(Matieres matiere) {
    setState(() {
      selectedMatiere = matiere;
    });
  }

  List<Widget> createRadioListMatieres() {
    List<Widget> widgets = [];
    widgets.add(DropdownButton<String>(
      value: selectedVille,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          selectedVille = newValue;
        });
      },
      items: <String>['Libreville', 'Franceville', 'Moanda', 'Port-Gentil']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));

    widgets.add(
      Container(
        margin: EdgeInsets.all(12.0),
        constraints: BoxConstraints.tight(const Size(300, 50)),
        child: new TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Tapez un deuxième numéro",
          ),
          keyboardType: TextInputType.number,
          onChanged: (string) {
            setState(() {
              phone2 = string;
            });
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
    );

    widgets.add(MultiSelect(
      autovalidate: true,
      initialValue: ['6ième', '5ième'],
      titleText: 'Country of Residence',
      maxLength: 5, // optional
      validator: (dynamic value) {
        if (value == null) {
          return 'Please select one or more option(s)';
        }
        return null;
      },
      errorText: 'Please select one or more option(s)',
      dataSource: [
        {
          "display": "6ième",
          "value": "6ième",
        },
        {
          "display": "5ième",
          "value": "5ième",
        },
        {
          "display": "4ième",
          "value": "4ième",
        },
        {
          "display": "3ième",
          "value": "3ième",
        },
        {
          "display": "2nde",
          "value": "2nde",
        },
        {
          "display": "1ère",
          "value": "1ère",
        },
        {
          "display": "Terminale A1",
          "value": "Terminale A1",
        },
        {
          "display": "Terminale A2",
          "value": "Terminale A2",
        },
        {
          "display": "Terminale B",
          "value": "Terminale B",
        },
        {
          "display": "Terminale C",
          "value": "Terminale C",
        },
        {
          "display": "Terminale D",
          "value": "Terminale D",
        }
      ],
      textField: 'display',
      valueField: 'value',
      filterable: true,
      required: true,
      selectIcon: Icons.arrow_drop_down_circle,
      saveButtonColor: Theme.of(context).primaryColor,
      checkBoxColor: Theme.of(context).primaryColorDark,
      cancelButtonColor: Theme.of(context).primaryColorLight,
      onSaved: (value) {
        if (value == null) {
          print("ya rien");
        } else {
          setState(() {
            _myActivities = value;
          });
        }
      },
    ));
    for (Matieres matiere in matieres) {
      widgets.add(
        RadioListTile(
          value: matiere,
          groupValue: selectedMatiere,
          title: Text(matiere.name),
          onChanged: (currentMatiere) {
            setSelectedClasse(currentMatiere);
          },
          selected: selectedMatiere == matiere,
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(),
        body: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: isLoading
                  ? new Center(
                      child: CircularProgressIndicator(),
                    )
                  : new Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text("Sélection"),
                          ),
                          Text("Choisissez votre matière"),
                          Column(
                            children: createRadioListMatieres(),
                          ),
                          new RaisedButton(
                            onPressed: () {
                              if (selectedMatiere == null) {
                                erreurSelection(context);
                              } else {
                                setState(() {
                                  _myActivitiesResult =
                                      _myActivities.toString();
                                });
                                _onFormSaved();
                                print(_myActivitiesResult);
                                //enregistreProf(context,nomComplet,phone,email,password,selectedMatiere);
                              }
                            },
                            color: Colors.blue,
                            child: new Text(
                              "Confirmez",
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                    ),
            );
          },
        ));
  }

  void _onFormSaved() {
    final FormState form = _formKey.currentState;
    form.save();
    print(form);
  }

  void erreurSelection(BuildContext context) {
    Scaffold.of(context).showSnackBar(
        new SnackBar(content: new Text("Vous n'avez choisie aucune matière")));
  }

  Future<void> enregistreProf(
      BuildContext context,
      String nomComplet,
      String phone,
      String email,
      String password,
      Matieres selectedMatiere) async {
    String form = '{"user":{"fullname": "' +
        nomComplet +
        '","phone":"' +
        phone +
        '","email": "' +
        email +
        '","password": "' +
        password +
        '"},"student":{"idsubjects":"' +
        selectedMatiere.idsubjects.toString() +
        '"}}';
    print(form);
    var response = await Authentification.register(form, 'teachers');
    if (response.statusCode == 201) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text("done")));
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new Connexion()));
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(jsonResponse['error'])));
      print(jsonResponse['error']);
    }
  }
}
