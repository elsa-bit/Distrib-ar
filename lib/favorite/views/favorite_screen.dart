import 'package:distribar/cocktail/viewmodel_cocktail.dart';
import 'package:distribar/details/views/detail_cocktail.dart';
import 'package:distribar/favorite/item_favorite_element.dart';
import 'package:distribar/utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    getFavoritesFromSharedPreferences().then((value) {
      setState(() {
        favorites = value;
      });
    });
  }

  Future<List<String>> getFavoritesFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              'Mes Favoris',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: MyColors.blueFonce,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final id = favorites[index];

                return FutureBuilder<Map<String, dynamic>>(
                  future: ViewModelCocktail.getCocktailDetailsById(id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final cocktail = snapshot.data!;
                      final name = cocktail['strDrink'];
                      final photo = cocktail['strDrinkThumb'];

                      return GestureDetector(
                        onTap: () {
                          _detailCocktail(id);
                        },
                        child: ItemCartElement(
                          id: id,
                          photo: photo,
                          name: name,
                          callback: (bool) {
                            _removeFavorite(id);
                          },
                        ),
                      );
                    }else if (snapshot.hasError) {
                      return ListTile(
                        title: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return const ListTile(
                        title: Text('Loading...'),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _removeFavorite(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    if (favorites.contains(id)) {
      favorites.remove(id);
    }

    await prefs.setStringList('favorites', favorites);
    setState(() {
      this.favorites = favorites;
    });
  }

  void _detailCocktail(id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail(id: id)),
    );
  }
}
