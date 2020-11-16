import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../Config.dart';

class TypeDocs{
  int idtypedocs;
  String name;
 TypeDocs(int id, String name){
    this.idtypedocs = id;
    this.name= name;
  }
  static Future<List<TypeDocs>> getTypeDoc() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Config('typedocs').urlFinal);
    if (response.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<TypeDocs> typedocs = [];
      jsonResponse['rows'].forEach((typedoc){
        typedocs.add(new TypeDocs(typedoc['idtypedocs'], typedoc['name']));
      });
      return typedocs;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

}