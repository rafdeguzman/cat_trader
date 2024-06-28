// this class is to get from cat api

import 'dart:convert';

import 'package:flutter/services.dart';
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

  static getCatDetails(String id) async {
    // https://api.thecatapi.com/v1/images/d55E_KMKZ
    var catsUrl = 'api.thecatapi.com';
    var catsPath = 'v1/images/$id';
    var queryParams = {
      'x-api-key': dotenv.env['CAT_API_KEY'],
    };
    var url = Uri.https(catsUrl, catsPath, queryParams);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var responseBody = json.decode(response.body);

    var breed = responseBody['breeds'][0]['name'];
    var breedId = responseBody['id'];
    var description = responseBody['breeds'][0]['description'];
    var lifeSpan = responseBody['breeds'][0]['life_span'];
    var origin = responseBody['breeds'][0]['origin'];
    var originId = responseBody['breeds'][0]['country_code'];

    var catDetails = {
      'breed': breed,
      'breedId': breedId,
      'description': description,
      'lifeSpan': lifeSpan,
      'origin': origin,
      'originId': originId,
    };

    return catDetails;
  }

  static Future<List<dynamic>> getCatBreedImages(String breeds) async {
    var catsUrl = 'api.thecatapi.com';
    var catsPath = 'v1/images/search';
    var queryParams = {
      'breed_ids': breeds,
      'limit': '20',
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

  static Future<dynamic> loadBreeds() async {
    {
      final String breedsJson =
          await rootBundle.loadString('assets/breeds.json');
      return jsonDecode(breedsJson);
    }
  }
}
