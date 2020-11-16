import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../Config.dart';

class Matieres {
  int idsubjects;
  String name;
  int countDoc;
  int countAnswer;
  Matieres(int id, String name, [this.countDoc, this.countAnswer]) {
    this.idsubjects = id;
    this.name = name;

  }
  static Future<List<Matieres>> getMatiere() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Config('subjects').urlFinal);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<Matieres> matieres = [];
      jsonResponse['rows'].forEach((matiere) {
        matieres.add(new Matieres(matiere['idsubjects'], matiere['name']));
      });
      return matieres;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<List<Matieres>> getMatiereClasse(int idclasses) async {
    // Await the http get response, then decode the json-formatted response.
    var response =
        await http.get(Config('classes/${idclasses}/subjects/stats').urlFinal);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<Matieres> matieres = [];
      jsonResponse['subjectHasClasses'].forEach((matiere) {
        matieres.add(new Matieres(matiere['idsubjects'], matiere['name'],
            matiere['countDocument'], matiere['countAnswer']));
      });
      return matieres;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
