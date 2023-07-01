import 'dart:convert';

import 'package:distribar/ancien_projet/cocktail/data_model_cocktail.dart';
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
}
