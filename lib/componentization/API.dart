import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/user.dart';

class FetchUser {
  Future<List<User>> getPaciente({String? query}) async {
    var data = [];
    String urlList = 'https://api-tb-koch.onrender.com/';
    var url = Uri.parse(urlList);
    List<User> results = [];
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map<User>(User.fromMap).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.nome.toLowerCase().contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print('API ERROR');
      }
    } on Exception catch (e) {
      print('ERROR: $e');
    }
    return results;
  }
}
