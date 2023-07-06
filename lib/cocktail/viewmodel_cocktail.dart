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

  static Future<DataClassTableCocktail> fetchCocktailsByIngredient(
      List<String> ingredients) async {
    List<DataClassCocktail> cocktailList = [];

    for (String ingredient in ingredients) {
      final response = await http.get(Uri.parse(
          "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=$ingredient"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['drinks'] != null) {
          final drinks = data['drinks'] as List<dynamic>;
          for (var drink in drinks) {
            final cocktail = DataClassCocktail.fromJson(drink);
            cocktailList.add(cocktail);
          }
          /**
           * [{strDrink: 50/50, strDrinkThumb: https://www.thecocktaildb.com/images/media/drink/wwpyvr1461919316.jpg, idDrink: 14598},
           * {strDrink: A Day at the Beach, strDrinkThumb: https://www.thecocktaildb.com/images/media/drink/trptts1454514474.jpg, idDrink: 15200},
           * {strDrink: A Gilligan's Island, strDrinkThumb: https://www.thecocktaildb.com/images/media/drink/wysqut1461867176.jpg, idDrink: 16943},
           * {strDrink: A Night In Old Mandalay, strDrinkThumb: https://www.thecocktaildb.com/images/media/drink/vyrvxt1461919380.jpg, idDrink: 17832},
           * {strDrink: Abbey Martini, strDrinkThumb: https://www.thecocktaildb.com/images/media/drink/2mcozt1504817403.jpg, idDrink: 17223},
           * {strDrink: Abilene, strDrinkThumb: https://www.thecocktaildb.com/images/media/drink/smb2oe1582479072.jpg, idDrink: 17835},
           * {strDrink: Absolutly Screwed Up, strDrinkThumb: https://www.thecocktaildb.com/images/media/drink/yvxrwv1472669728.jpg, idDrink: 16134}]
           */
        }
      } else {
        throw Exception('Failed to download cocktails by ingredient');
      }
    }

    return DataClassTableCocktail(dataClassCocktail: cocktailList);
  }
}
