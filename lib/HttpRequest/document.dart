import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../Config.dart';

class Documents {
  int idDocument;
  String nomDocument;
  int yearPub;
  bool statut;
  String path;
  String pathAnswer;
  String notions;

  Documents(int idDocument, String nomDocument, int yearPub, bool statut,
      String path, String pathAnswer, String notions) {
    this.idDocument = idDocument;
    this.nomDocument = nomDocument;
    this.yearPub = yearPub;
    this.statut = statut;
    this.path = path;
    this.pathAnswer = pathAnswer;
    this.notions = notions;
  }

  static Future<List<Documents>> getDocuments(
      int idClasse, int idMatiere, int typeDoc) async {
    var url =
        "classes/${idClasse}/subjects/${idMatiere}/documents?typedocs=${typeDoc}";

    var response = await http.get(Config(url).urlFinal);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      List<Documents> documents = [];
      jsonResponse['docInClasseSubject'].forEach((document) {
        if (document['docAnswer'] == null) {
          if (document["Notion"] == null) {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                null,
                "Notions inconnues"));
          } else {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                null,
                document["Notion"]["notions"]));
          }
        } else {
          if (document["Notion"] == null) {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                document['docAnswer']['pathfile'],
                "Notions inconnues"));
          } else {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                document['docAnswer']['pathfile'],
                document["Notion"]["notions"]));
          }
        }
      });
      return documents;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<List<Documents>> getDocumentClasseRandom(int idClasse) async {
    var url = "classes/${idClasse}/documents/random";

    var response = await http.get(Config(url).urlFinal);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      List<Documents> documents = [];
      jsonResponse['docInClasseSubject'].forEach((document) {
        if (document['docAnswer'] == null) {
          if (document["Notion"] == null) {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                null,
                "Notions inconnues"));
          } else {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                null,
                document["Notion"]["notions"]));
          }
        } else {
          if (document["Notion"] == null) {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                document['docAnswer']['pathfile'],
                "Notions inconnues"));
          } else {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                document['docAnswer']['pathfile'],
                document["Notion"]["notions"]));
          }
        }
      });
      return documents;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<List<Documents>> getDocumentSubjectRandom(int idSubject) async {
    var url = "subjects/${idSubject}/documents/random";

    var response = await http.get(Config(url).urlFinal);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      List<Documents> documents = [];
      jsonResponse['docInClasseSubject'].forEach((document) {
        if (document['docAnswer'] == null) {
          if (document["Notion"] == null) {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                null,
                "Notions inconnues"));
          } else {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                null,
                document["Notion"]["notions"]));
          }
        } else {
          if (document["Notion"] == null) {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                document['docAnswer']['pathfile'],
                "Notions inconnues"));
          } else {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                document['docAnswer']['pathfile'],
                document["Notion"]["notions"]));
          }
        }
      });
      return documents;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<List<Documents>> getDocInClasseSubject(
      idclasses, idsubjects) async {
    var url = "classes/${idclasses}/subjects/${idsubjects}/documents";

    var response = await http.get(Config(url).urlFinal);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      List<Documents> documents = [];
      jsonResponse['docInClasseSubject'].forEach((document) {
        if (document['docAnswer'] == null) {
          if (document["Notion"] == null) {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                null,
                "Notions inconnues"));
          } else {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                null,
                document["Notion"]["notions"]));
          }
        } else {
          if (document["Notion"] == null) {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                document['docAnswer']['pathfile'],
                "Notions inconnues"));
          } else {
            documents.add(Documents(
                document["iddocuments"],
                document["name"],
                document["year"],
                document["status"],
                document["pathfile"],
                document['docAnswer']['pathfile'],
                document["Notion"]["notions"]));
          }
        }
      });
      return documents;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
