import 'package:academia26102020/HttpRequest/typedoc.dart';
import 'package:academia26102020/read_pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/rendering.dart';

import 'HttpRequest/document.dart';

class DocType extends StatefulWidget {
  int matiereId;
  int classeId;
  TypeDocs typeDoc;

  DocType(this.classeId, this.matiereId, this.typeDoc);

  DocTypeState createState() =>
      new DocTypeState(this.classeId, matiereId, typeDoc);
}

class DocTypeState extends State<DocType> {
  int matiereId;
  int classeId;
  TypeDocs typeDoc;
  bool isloading = true;

  PDFDocument lireDocument;

  DocTypeState(this.classeId, this.matiereId, this.typeDoc);

  List<Documents> documents;

  @override
  void initState() {
    super.initState();

    onLoad();
  }

  onLoad() async {
    documents =
        await Documents.getDocuments(classeId, matiereId, typeDoc.idtypedocs);
    print(documents);
    setState(() {
      isloading = false;
    });
  }

  List<Widget> createListileDocument(BuildContext context) {
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
  Widget build(BuildContext context) {
    return new Scaffold(body: Builder(
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: isloading
              ? new Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new Container(
                      padding: new EdgeInsets.all(3.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ))
              : new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text('${createListileDocument(context).length}'),
                      ),
                      label: Text('documents'),
                    ),
                    Column(
                      children: createListileDocument(context),
                    ),
                  ],
                ),
        );
      },
    ));
  }
}
