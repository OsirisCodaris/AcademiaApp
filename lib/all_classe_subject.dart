import 'dart:math';

import 'package:academia26102020/HttpRequest/classe.dart';
import 'package:academia26102020/HttpRequest/document.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Components/docPopulaire.dart';
import 'Components/menuStud.dart';
import 'LocalRequest/localDatabase.dart';
import 'doc_subject.dart';

import 'package:percent_indicator/percent_indicator.dart';

class AllClasseSubject extends StatefulWidget {
  @override
  _AllClasseSubjectState createState() => _AllClasseSubjectState();
}

class _AllClasseSubjectState extends State<AllClasseSubject> {
  List<Classes> classes;
  bool isLoading = true;
  List<Map<String, dynamic>> queryRows;
  List<Documents> pop_doc;

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  onLoad() async {
    queryRows = await DatabaseHelper.instance.user();
    print(queryRows[0]['module']);
    classes = await Classes.getClassesSubject(queryRows[0]['module']);
    pop_doc = await Documents.getDocumentSubjectRandom(queryRows[0]['module']);
    setState(() {
      isLoading = false;
    });
  }

  List<Widget> createCardListMatieresClasses() {
    List<Widget> widgets = [];

    for (Classes classe in classes) {
      double pourcentage = classe.countDoc != null && classe.countAnswer != null
          ? classe.countDoc > 0 && classe.countAnswer > 0
              ? ((classe.countAnswer * 100) / classe.countDoc).toDouble()
              : 0
          : 0;

      double pourcentageSimple = pourcentage / 100;

      //design de la card
      final matierecard = new Card(
          color: Theme.of(context).primaryColor,
          child: GestureDetector(
            child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 3.0, right: 3.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 3.0,
                          percent: pourcentageSimple,
                          center: new Text("${pourcentage.truncate()} %"),
                          progressColor: Theme.of(context).accentColor,
                        )),
                    Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(classe.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(fontSize: 15),
                                    text: 'Documents :', // default text style
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              ' ' + classe.countDoc.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(fontSize: 15),
                                    text: 'Corrigés :', // default text style
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' ' +
                                              classe.countAnswer.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                )),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new DocSubject(classe.idclasses, classe.name)));
            },
          ));

      widgets.add(
        Container(
          height: 108,
          width: double.infinity,
          margin: EdgeInsets.only(left: 18.0, right: 18.0),
          child: matierecard,
        ),
      );
    }
    return widgets;
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text('Académia'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: isLoading
                      ? () {}
                      : () {
                          setState(() {
                            isLoading = true;
                            onLoad();
                          });
                        },
                  child: Icon(
                    Icons.refresh,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        drawer: MenuStud(),
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
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  strokeWidth: 3.0,
                                ),
                              )
                            ],
                          ))
                        : Column(
                            children: [
                              Container(
                                child: Text(
                                  'Documents Populaires',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              DocPopulaire(pop_doc),
                              Divider(),
                              Container(
                                child: Text(
                                  'Classes',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Column(
                                children: createCardListMatieresClasses(),
                              )
                            ],
                          )));
          },
        ));
  }
}
