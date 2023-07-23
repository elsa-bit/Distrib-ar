import 'package:distribar/cocktail/data_model_cocktail.dart';
import 'package:distribar/cocktail/viewmodel_cocktail.dart';
import 'package:distribar/utils/MyColors.dart';
import 'package:distribar/utils/custom_views/item_card_cocktail.dart';
import 'package:distribar/utils/custom_views/no_cocktail_found.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCocktail extends StatefulWidget {
  const MyCocktail({Key? key}) : super(key: key);

  @override
  State<MyCocktail> createState() => _MyCocktailState();
}

class _MyCocktailState extends State<MyCocktail> {
  Future<DataClassTableCocktail>? futureCocktail;
  List<String> listConfig = [];

  gridViewOfCocktails(AsyncSnapshot<DataClassTableCocktail> snapshot) {
    if (snapshot.data != null && snapshot.data!.dataClassCocktail.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.65),
        ),
        itemCount: snapshot.data!.dataClassCocktail.length,
        itemBuilder: (context, index) {
          return ItemCardCocktail(
            cocktailId: snapshot.data!.dataClassCocktail[index].idCocktail,
            cocktailTitle: snapshot.data!.dataClassCocktail[index].nameCocktail,
            urlImage: snapshot.data!.dataClassCocktail[index].urlImage,
          );
        },
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 60.0),
        child: NoCocktailFound(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    futureCocktail = null;
    _recupConfig();
  }

  _recupConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String idDistribar = prefs.getString('id_Distribar') ?? '';

    final ref = FirebaseDatabase.instance.ref();
    for (var i = 1; i <= 5; i++) {
      final snapshot = await ref.child('$idDistribar/config/gpio$i').get();
      if(snapshot.value != ""){
        listConfig.add(snapshot.value as String);
      }
    }

    futureCocktail = ViewModelCocktail.fetchCocktailsByIngredient(listConfig);
    setState(() {
      futureCocktail = futureCocktail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: Image.asset('assets/images/fleche_blue.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 25),
                child: Text(
                  'Cherchez votre cocktail',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: MyColors.blueFonce,
                  ),
                ),
              ),
            ],
          ),
          /** Call api to parse information into cards of cocktails **/
          Flexible(
            child: FutureBuilder<DataClassTableCocktail>(
              future: futureCocktail,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: NoCocktailFound(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return gridViewOfCocktails(snapshot);
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
