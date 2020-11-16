import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Components/docPopulaire.dart';
import 'HttpRequest/document.dart';
import 'HttpRequest/matiere.dart';
import 'LocalRequest/localDatabase.dart';
import 'doc_subject.dart';
import 'Components/menuStud.dart';

import 'package:loading_animations/loading_animations.dart';

import 'package:percent_indicator/percent_indicator.dart';

class AllSubject extends StatefulWidget {
  @override
  _AllSubjectState createState() => _AllSubjectState();
}

class _AllSubjectState extends State<AllSubject> {
  List<Matieres> matieres;
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
    print(queryRows[0]);
    matieres = await Matieres.getMatiereClasse(queryRows[0]['module']);
    pop_doc = await Documents.getDocumentClasseRandom(queryRows[0]['module']);
    setState(() {
      isLoading = false;
    });
  }

  List<Widget> createCardListMatieresClasses() {
    List<Widget> widgets = [];

    for (Matieres matiere in matieres) {
      double pourcentage =
          matiere.countDoc != null && matiere.countAnswer != null
              ? matiere.countDoc > 0 && matiere.countAnswer > 0
                  ? ((matiere.countAnswer * 100) / matiere.countDoc).toDouble()
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
                    child: Container(
                        child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 3.0,
                              percent: pourcentageSimple,
                              center: new Text("${pourcentage.truncate()} %"),
                              progressColor: Theme.of(context).accentColor,
                            ))
                      ],
                    )),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(matiere.name,
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
                                  text: 'Documents :', // default text style
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' ' + matiere.countDoc.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'Corrigés :', // default text style
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' ' +
                                            matiere.countAnswer.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new DocSubject(matiere.idsubjects, matiere.name)));
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
        drawer: MenuStud(), //appelle du menu de l'élève
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
                                child: LoadingBouncingGrid
                                    .square(), //loading top là
                              )
                            ],
                          ))
                        : Column(
                            children: [
                              Container(
                                child: Text(
                                  'Documents Populaires',
                                  style: Theme.of(context).textTheme.headline2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              DocPopulaire(
                                  pop_doc), //appelle du composant des docs popu
                              Divider(),
                              Container(
                                child: Text(
                                  'Matières',
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
