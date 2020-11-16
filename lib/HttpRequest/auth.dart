import 'package:http/http.dart' as http;

import '../Config.dart';

class Authentification{
  static Future<dynamic> register  (String form,String table) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await http.post(Config(table).urlFinal, headers: headers,body: form);
    return response;
  }

  static Future<dynamic> authentifier  (String form,String table) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await http.post(Config(table).urlFinal, headers: headers,body: form);
    return response;
  }
}