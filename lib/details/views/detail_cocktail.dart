import 'dart:ui';

import 'package:distribar/details/data_model_detail.dart';
import 'package:distribar/details/viewmodel_detail.dart';
import 'package:distribar/utils/MyColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  String? id;

  Detail({Key? key, required this.id}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<DataClassTableDetail> futureCocktail;
  final ref = FirebaseDatabase.instance.ref();
  String idDistribar = '';
  bool ingredientAdded = false;
  bool showButtonCocktail = false;
  List<String?> listIngredient = [];
  List<String?> listConfig = [];
  List<String?> favorites = [];

  @override
  void initState() {
    super.initState();
    futureCocktail = ViewModelDetail.fetchSpecialCocktail(widget.id);
    getFavoritesFromSharedPreferences().then((favorites) {
      setState(() {
        this.favorites = favorites;
      });
    });
    _getConfigDistribar();
  }

  Future<List<String>> getFavoritesFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  void _getConfigDistribar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    idDistribar = prefs.getString('id_Distribar') ?? '';
    for (var i = 1; i <= 5; i++) {
      final snapshot = await ref.child('$idDistribar/config/gpio$i').get();
      listConfig.add(snapshot.value as String?);
    }
  }

  detailCocktail(AsyncSnapshot<DataClassTableDetail> snapshot) {
    final cocktail = snapshot.data?.dataClassDetail[0];
    var image = cocktail?.urlImage;
    var name = cocktail?.nameCocktail;
    var alc = cocktail?.alcoholic;

    if (!ingredientAdded) {
      listIngredient.addAll([
        cocktail?.ingredient1,
        cocktail?.ingredient2,
        cocktail?.ingredient3,
        cocktail?.ingredient4,
        cocktail?.ingredient5,
        cocktail?.ingredient6,
        cocktail?.ingredient7,
      ].where((ingredient) => ingredient != null && ingredient.isNotEmpty));

      showButtonCocktail = listIngredient.any((ingredient) => listConfig.contains(ingredient));
      ingredientAdded = true;
    }

    //Convertir la liste en String
    var detailResult = listIngredient.join(" // ");

    if (snapshot.data != null) {
      return Column(
        children: [
          Stack(
            children: [
              /**
               * Image du cocktail
               */
              Container(
                child: ClipRRect(
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(image!),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 70),
                  child: Image.asset('assets/images/fleche.png'),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    /**
                     * Button Alcoholic or No
                     */
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 20,
                          width: 90,
                          decoration: BoxDecoration(
                            color: MyColors.bluePale,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              alc!,
                              style:
                                  TextStyle(fontSize: 11, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /**
                   * Nom du cocktail
                   */
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    name!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  favorites.contains(widget.id)
                      ? Icon(
                          Icons.favorite,
                          color: MyColors.blueMedium,
                          size: 35,
                        )
                      : GestureDetector(
                          onTap: _registerFavorite,
                          child: Icon(
                            Icons.favorite_border,
                            color: MyColors.blueMedium,
                            size: 35,
                          ),
                        ),
                  /**
                   * Ingredients
                   */
                  Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Ingredients",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyColors.blueFonce,
                              fontSize: 16),
                        ),
                        CustomPaint(
                          size: Size(20, 20),
                          painter: MyPainter(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(1),
                            children: [Text(detailResult)],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /**
                   * Bouton de fabrication
                   */
                  showButtonCocktail
                      ? TextButton(
                          onPressed: () {
                            if (widget.id != null) {
                              _setCocktail();
                            } else {
                              _showSnackBar(
                                  context,
                                  "A problem occurs, please try later ",
                                  Colors.orangeAccent);
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 35,
                              width: 120,
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: MyColors.blueDark,
                              ),
                              child: Text(
                                "Faire le cocktail",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return const Text("Pas de cocktails disponible.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Flexible(
          child: FutureBuilder<DataClassTableDetail>(
            future: futureCocktail,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Error : ${snapshot.error}');
                return const Text("An error occurs, try later.");
              } else if (snapshot.hasData) {
                return detailCocktail(snapshot);
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ]),
    );
  }

  void _setCocktail() async {
    List<String> listConfig = [];

    for (var i = 1; i <= 5; i++) {
      final snapshot = await ref.child('$idDistribar/config/gpio$i').get();
      for (var ingredient in listIngredient) {
        if (ingredient == snapshot.value) {
          listConfig.add(ingredient!);
        }
      }
    }

    final snapshotCocktail = await ref.child('$idDistribar/cocktails').get();
    if (snapshotCocktail.value == "" || snapshotCocktail.value == null) {
      ref.child(idDistribar).update({"cocktails": listConfig});
      _showSnackBar(context, "Cocktail en préparation...", Colors.greenAccent);
    } else {
      _showSnackBar(
          context, "Il y a déjà un cocktail en cours !", Colors.orangeAccent);
    }
  }

  void _registerFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    if (!favorites.contains(widget.id)) {
      favorites.add(widget.id!);
      await prefs.setStringList('favorites', favorites);
      setState(() {
        this.favorites = favorites;
      });
    }
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(-70, 25);
    final p2 = Offset(300, 25);
    final paint = Paint()
      ..color = MyColors.blueFonce
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

void _showSnackBar(BuildContext context, String text, Color background) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: background,
    ),
  );
}
