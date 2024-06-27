// this class is to get from cat api

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CatsApi {
  static Future<List<dynamic>> getCats() async {
    var catsUrl = 'api.thecatapi.com';
    var catsPath = 'v1/images/search';
    var url = Uri.https(catsUrl, catsPath);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var responseBody = json.decode(response.body);
    return List<Map<String, dynamic>>.from(responseBody);
  }

  static Future<List<dynamic>> getCatBreeds() async {
    var catsUrl = 'api.thecatapi.com';
    var catsPath = 'v1/breeds';
    var url = Uri.https(catsUrl, catsPath);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var responseBody = json.decode(response.body);
    return List<Map<String, dynamic>>.from(responseBody);
  }

  static Future<List<dynamic>> getCatBreedImages(String breed) async {
    var catsUrl = 'api.thecatapi.com';
    var catsPath = 'v1/images/search';
    var queryParams = {
      'breed_ids': breed,
      'limit': '10',
      'x-api-key': dotenv.env['CAT_API_KEY']
    }; // Provide the query parameters
    var url = Uri.https(
        catsUrl, catsPath, queryParams); // Pass the query parameters to the Uri
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var responseBody = json.decode(response.body);
    return List<Map<String, dynamic>>.from(responseBody);
  }
  // https://api.thecatapi.com/v1/images/search?limit=10&breed_ids=beng
}
