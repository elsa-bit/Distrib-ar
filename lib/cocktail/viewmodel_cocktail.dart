import 'dart:convert';

import 'package:distribar/cocktail/data_model_cocktail.dart';
import 'package:http/http.dart' as http;

class ViewModelCocktail {
  static Future<DataClassTableCocktail> fetchRandomCocktail() async {
    final response = await http.get(Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"));
    if (response.statusCode == 200) {
      return DataClassTableCocktail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to download random cocktail');
    }
  }

  static Future<Map<String, dynamic>> getCocktailDetailsById(String id) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['drinks'][0];
    } else {
      throw Exception('Failed to fetch cocktail details');
    }
  }


}
