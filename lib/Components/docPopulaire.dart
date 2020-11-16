import 'dart:math';
import 'package:academia26102020/HttpRequest/document.dart';
import 'package:academia26102020/read_pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocPopulaire extends StatefulWidget {
  List<Documents> list_doc = [];
  DocPopulaire(this.list_doc) {}
  @override
  _DocPopulaireState createState() => _DocPopulaireState(list_doc);
}

class _DocPopulaireState extends State<DocPopulaire> {
  int _index = 0;
  List<Documents> listDoc = [];
  _DocPopulaireState(this.listDoc);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: listDoc.length > 0

          ?

      SizedBox(
        height: 200, // card height
        child: PageView.builder(
          itemCount: listDoc.length,
          controller: PageController(viewportFraction: 0.3),
          onPageChanged: (int index) => setState(() => _index = index),
          itemBuilder: (_, i) {
            return Transform.scale(
              scale: i == _index ? 1 : 0.7,
              child:GestureDetector(
                  onTap:(){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new ReadPDF(listDoc[i].path, listDoc[i].pathAnswer, "Voir le corrigé")));
                } ,
                  child:  Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors
                            .primaries[Random().nextInt(Colors.primaries.length)],
                        elevation: 6,                   
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                        child: Container(
                            margin: EdgeInsets.only(top: 9.0, bottom: 9.0),
                            color: Colors.white,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.picture_as_pdf,
                                  size: 36,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text("${listDoc[i].yearPub}",
                                    style: Theme.of(context).textTheme.subtitle2)
                              ],
                            ))),
                      ),
                      
                    ),
                    Center(
                      child: Text(
                        "${listDoc[i].nomDocument}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              )
            );
          },
        ),
      ) : Center(child: Text("Pas de document"),),
    );
  }
}
