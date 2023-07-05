import 'package:distribar/cocktail/viewmodel_cocktail.dart';
import 'package:distribar/utils/MyColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/custom_views/item_card_cocktail.dart';
import '../utils/custom_views/no_cocktail_found.dart';
import 'data_model_cocktail.dart';

class Cocktail extends StatefulWidget {
  const Cocktail({Key? key}) : super(key: key);

  @override
  State<Cocktail> createState() => _CocktailState();
}

class _CocktailState extends State<Cocktail> {
  late Future<DataClassTableCocktail> futureCocktail;
  String _scanQRcode = 'Unknown';

  gridViewOfCocktails(AsyncSnapshot<DataClassTableCocktail> snapshot) {
    if (snapshot.data != null) {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.65)),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ItemCardCocktail(
            cocktailId: snapshot.data?.dataClassCocktail[index].idCocktail,
            cocktailTitle: snapshot.data?.dataClassCocktail[index].nameCocktail,
            urlImage: snapshot.data?.dataClassCocktail[index].urlImage,
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
    futureCocktail = ViewModelCocktail.fetchRandomCocktail()
        as Future<DataClassTableCocktail>;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /** Top Logo **/
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Image.asset(
              'assets/distribar_logo.png',
              height: 53,
              width: 53,
            ),
          ),
        ),
        /** Image Banner **/
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.black,
                child: Image.asset(
                  'assets/images/homme_bar.jpg',
                  fit: BoxFit.fitWidth,
                  color: Colors.white.withOpacity(0.4),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Prepare on the app,\nCollect at my bar.',
                  style: TextStyle(
                      height: 2.0,
                      fontFamily: 'AlegreyaSans',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 30),
            TextButton(
              onPressed: () {},
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
                    color: MyColors.blue,
                  ),
                  child: Text(
                    "Faire mes cocktails",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 60),
            TextButton(
              onPressed: () => QrCodeScan(),
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
                    color: MyColors.blueMedium,
                  ),
                  child: Text(
                    "Scanner ma Distrib'ar",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
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
                print('Error : ${snapshot.error}');
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
    );
  }

  Future<void> QrCodeScan() async {
    String QrCodeScanRes;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      QrCodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      await prefs.setString('id_Distribar', QrCodeScanRes);

      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child(QrCodeScanRes).get();
      if (!snapshot.exists) {
        DatabaseReference ref = FirebaseDatabase.instance.ref(QrCodeScanRes);
        await ref.set({
          "config": {
            "gpio1": "",
            "gpio2": "",
            "gpio3": "",
            "gpio4": "",
            "gpio5": "",
          }
        });
      }
    } on PlatformException {
      QrCodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanQRcode = QrCodeScanRes;
    });
  }
}
