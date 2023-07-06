import 'package:distribar/utils/MyColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:select_searchable_list/select_searchable_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config extends StatefulWidget {
  const Config({Key? key}) : super(key: key);

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  bool isButtonHovered = false;
  int selectedBottle = 0;
  String idDistribar = '';
  TextEditingController _alcoholController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref();

  final Map<int, String> _listAlcohol = {
    0: 'Orange juice',
    1: 'Amaretto',
    2: 'Absolut Citron',
    3: 'Grenadine',
    4: 'Vodka',
    5: 'Sprite',
    6: 'Roses sweetened lime juice',
    7: 'Cranberry Juice',
    8: 'Orange Curacao',
    9: 'Strawberry liqueur',
    10: 'Gin',
    11: 'Grand Marnier',
    12: 'Lemon Juice',
    13: 'Soda Water',
    14: 'Champagne',
    15: 'Triple sec',
    16: 'Ginger ale',
    17: 'Cognac',
    18: 'Fresh Lemon Juice',
    19: 'Creme de Cassis',
    20: 'Water',
    21: 'Sugar Syrup',
    22: 'Pineapple juice',
    23: 'White wine',
    24: 'Aperol',
    25: 'Prosecco',
    26: 'Apple juice',
    27: 'Jack Daniels',
    28: 'Midori melon liqueur',
    29: 'Banana Liqueur',
    30: 'Iced tea',
    31: 'Campari',
    32: 'maraschino liqueur',
    33: 'Blue Curacao',
    34: 'Passion fruit juice',
    35: 'Lemonade',
    36: 'Tequila',
    37: 'Absinthe',
  };
  final List<int> _selectedAlcohol = [1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 40),
                child: Text(
                  'Configurez \n votre bar',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: MyColors.blueFonce,
                  ),
                ),
              ),
              Text(
                'Spécifiez les alcools présents aux différents \n emplacements de votre Distrib’ar',
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/base_machine.png',
                      width: 200,
                      height: 200,
                    ),
                    Positioned(
                      top: 20,
                      left: -10,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _attributeSelectionedBottle(2);
                          });
                        },
                        icon: Icon(Icons.circle),
                        color: selectedBottle == 2
                            ? MyColors.bluePale
                            : MyColors.greyConfig,
                        iconSize: 60,
                      ),
                    ),
                    Positioned(
                      top: -10,
                      left: 62,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _attributeSelectionedBottle(3);
                          });
                        },
                        icon: Icon(Icons.circle),
                        color: selectedBottle == 3
                            ? MyColors.bluePale
                            : MyColors.greyConfig,
                        iconSize: 60,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: -10,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _attributeSelectionedBottle(4);
                          });
                        },
                        icon: Icon(Icons.circle),
                        color: selectedBottle == 4
                            ? MyColors.bluePale
                            : MyColors.greyConfig,
                        iconSize: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: -10,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _attributeSelectionedBottle(1);
                          });
                        },
                        icon: Icon(Icons.circle),
                        color: selectedBottle == 1
                            ? MyColors.bluePale
                            : MyColors.greyConfig,
                        iconSize: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: -10,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _attributeSelectionedBottle(5);
                          });
                        },
                        icon: Icon(Icons.circle),
                        color: selectedBottle == 5
                            ? MyColors.bluePale
                            : MyColors.greyConfig,
                        iconSize: 60,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Choisissez la boisson présente à l’emplacement \n choisi',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20,bottom: 15, right: 15, left: 15),
                child: DropDownTextField(
                  textEditingController: _alcoholController,
                  title: 'Alcohol',
                  hint: 'Select Alcohol',
                  options: _listAlcohol,
                  selectedOptions: _selectedAlcohol,
                  onChanged: (selectedIds) {
                    setState(() => _selectedAlcohol[0] = selectedIds![0]);
                  },
                ),
              ),
              const SizedBox(height: 10),
              IntrinsicWidth(
                child: ElevatedButton(
                  onPressed: () => _saveBottle(),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(MyColors.bluePale),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.save, color: Colors.white, size: 18),
                      SizedBox(width: 5),
                      Text(
                        'Enregister la bouteille',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _attributeSelectionedBottle(int location) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      selectedBottle = location;
    });
    idDistribar = prefs.getString('id_Distribar') ?? '';

    final snapshot = await ref.child('$idDistribar/config/gpio$location').get();
    _alcoholController.text = snapshot.value.toString();

    int selectedId = _listAlcohol.values.toList().indexOf(snapshot.value.toString());
    _selectedAlcohol[0] = selectedId;
  }

  void _saveBottle() {
    String selectedAlcohol =
        _listAlcohol.values.elementAt(_selectedAlcohol[0]);

    ref
        .child('$idDistribar/config')
        .update({"gpio$selectedBottle": selectedAlcohol});
  }
}
