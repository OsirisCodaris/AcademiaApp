import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:loading_animations/loading_animations.dart';

class ReadPDF extends StatefulWidget {
  String urlToRead;
  String urlToAction;
  String action;

  ReadPDF(this.urlToRead, this.urlToAction, this.action);

  @override
  _MyAppState createState() => _MyAppState(urlToRead, urlToAction, action);
}

class _MyAppState extends State<ReadPDF> {
  bool _isLoading = true;
  PDFDocument document;

  String urlToRead;
  String urlToAction;
  String action;
  String newAction;

  bool existCorrige = false;

  _MyAppState(this.urlToRead, this.urlToAction, this.action);

  @override
  void initState() {
    super.initState();
    loadDocument(urlToRead);
  }

  loadDocument(String urlToRead) async {
    if (urlToAction != null) {
      existCorrige = true;
    }
    document = await PDFDocument.fromURL(urlToRead);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black54,
          centerTitle: true,
          title: existCorrige
              ? new OutlineButton(
                  onPressed: () {
                    if (action == "Voir le corrigé") {
                      newAction = "Voir le sujet";
                    } else {
                      newAction = "Voir le corrigé";
                    }

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ReadPDF(
                                urlToAction, urlToRead, newAction)));
                  },
                  color: Theme.of(context).accentColor,
                  child: new Text(action),
                )
              : Text(
                  "Académia",
                  style: TextStyle(color: Colors.white24),
                )),
      body: Center(
        child: _isLoading
            ? Center(child: LoadingBouncingGrid.square())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
              ),
      ),
    );
  }
}
