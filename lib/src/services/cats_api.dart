// this class is to get from cat api

import 'dart:convert';

import 'package:http/http.dart' as http;

class CatsApi {
  static Future<List<dynamic>> getCats() async {
    var catsUrl = 'api.thecatapi.com';
    var catsPath = 'v1/images/search';
    var queryParams = {'limit': '3'};
    var url = Uri.https(catsUrl, catsPath, queryParams);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var responseBody = json.decode(response.body);
    var catMapList = List<Map<String, dynamic>>.from(responseBody);
    return catMapList;
  }
}
