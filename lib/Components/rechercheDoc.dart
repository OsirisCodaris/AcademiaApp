import 'package:academia26102020/HttpRequest/document.dart';
import 'package:academia26102020/HttpRequest/typedoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:academia26102020/LocalRequest/localDatabase.dart';
import 'package:academia26102020/doc_type.dart';

import '../read_pdf.dart';

//Class pour gérer la recherche
class DataSearch extends SearchDelegate<String> {
  List<Documents> docInClasse;
  final cities = ["Libreville", "Oyem", "Port-Gentil", "Moanda"];

  final recentCities = ["Lambarene", "Koulamoutou", "Lastourville", "Makokou"];

  DataSearch(this.docInClasse);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  List<Widget> createListileDocument(
      BuildContext context, List<Documents> documents) {
    List<Widget> widgets = [];
    for (Documents document in documents) {
      List<Card> notion = document.notions
          .split(';') // split the text into an array
          .map(
            (String text) => Card(
                margin:
                    EdgeInsets.only(left: 0, right: 1.6, bottom: 0, top: 1.6),
                color: Theme.of(context).primaryColor,
                elevation: 2.1,
                child: Container(
                  color: Colors.grey[300],
                  margin: EdgeInsets.only(left: 1.6, right: 1.6),
                  padding: EdgeInsets.all(1.2),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 11),
                  ),
                )),
          ) // put the text inside a widget
          .toList();
      widgets.add(Card(
          color: Theme.of(context).primaryColor,
          margin: EdgeInsets.all(0.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            margin: EdgeInsets.only(top: 1.0),
            color: Colors.white,
            child: ListTile(
              title: Text(document.nomDocument),
              subtitle: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: notion,
              ),
              //trailing: Text(document.yearPub.toString()),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    size: 21,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(document.yearPub.toString())
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ReadPDF(document.path,
                            document.pathAnswer, "Voir le corrigé")));
              },
            ),
          )));
    }
    return widgets;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          shape: StadiumBorder(),
          child: Center(
            child: Text(query),
          ),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? docInClasse
        : docInClasse
            .where((p) =>
                p.nomDocument.toLowerCase().contains(query.toLowerCase()) ||
                p.notions.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return SingleChildScrollView(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                  '${createListileDocument(context, suggestionList).length}'),
            ),
            label: Text('documents'),
          ),
          Column(
            children: createListileDocument(context, suggestionList),
          ),
        ],
      ),
    );
  }
}
