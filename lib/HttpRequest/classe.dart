import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../Config.dart';

class Classes {
  int idclasses;
  String name;
  int countDoc;
  int countAnswer;
  Classes(int id, String name,[this.countDoc, this.countAnswer]) {
    this.idclasses = id;
    this.name = name;
  }
  static Future<List<Classes>> getClasses() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Config('classes').urlFinal);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<Classes> classes = [];
      jsonResponse['rows'].forEach((classe) {
        classes.add(new Classes(classe['idclasses'], classe['name']));
      });
      return classes;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<List<Classes>> getClassesSubject(int idSubject) async {
    // Await the http get response, then decode the json-formatted response.
    
        var response =
            await http.get(Config('subjects/${idSubject}/classes/stats').urlFinal);
        if (response.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(response.body);
          List<Classes> classes = [];
          jsonResponse['subjectHasClasses'].forEach((classe) {
            classes.add(new Classes(classe['idclasses'], classe['name'],classe['countDocument'], classe['countAnswer']));
          });
          return classes;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    
    
  }

  Map<String, dynamic> toJson() => {"display": name, "value": name};
}
