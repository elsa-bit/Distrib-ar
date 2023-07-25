import 'package:distribar/utils/MyColors.dart';
import 'package:distribar/utils/custom_views/no_distribar_found.dart';
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
  late Future<String?> idDistribarFuture;
  String idDistribar = "";
  final TextEditingController _alcoholController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref();

  final Map<int, String> _listAlcohol = {
    0: '',
    1: 'Orange juice',
    2: 'Amaretto',
    3: 'Absolut Citron',
    4: 'Grenadine',
    5: 'Vodka',
    6: 'Sprite',
    7: 'Roses sweetened lime juice',
    8: 'Cranberry Juice',
    9: 'Orange Curacao',
    10: 'Strawberry liqueur',
    11: 'Gin',
    12: 'Grand Marnier',
    13: 'Lemon Juice',
    14: 'Soda Water',
    15: 'Champagne',
    16: 'Triple sec',
    17: 'Ginger ale',
    18: 'Cognac',
    19: 'Fresh Lemon Juice',
    20: 'Creme de Cassis',
    21: 'Water',
    22: 'Sugar Syrup',
    23: 'Pineapple juice',
    24: 'White wine',
    25: 'Aperol',
    26: 'Prosecco',
    27: 'Apple juice',
    28: 'Jack Daniels',
    29: 'Midori melon liqueur',
    30: 'Banana Liqueur',
    31: 'Iced tea',
    32: 'Campari',
    33: 'maraschino liqueur',
    34: 'Blue Curacao',
    35: 'Passion fruit juice',
    36: 'Lemonade',
    37: 'Tequila',
    38: 'Absinthe',
    39: 'Coca',
    40: 'Rum',
  };
  final List<int> _selectedAlcohol = [1];

  @override
  void initState() {
    super.initState();
    idDistribarFuture = _initializeDistribar();
  }

  Future<String?> _initializeDistribar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idDistribar = prefs.getString('id_Distribar') ?? "";
    });
    return prefs.getString('id_Distribar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<String?>(
          future: idDistribarFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final idDistribar = snapshot.data;
              if (idDistribar != null && idDistribar.isNotEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 20, bottom: 40, left: 80),
                          child: Text(
                            'Configurez \n votre bar',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: MyColors.blueFonce,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          decoration: const BoxDecoration(
                            color: MyColors.bluePale,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              _confirmCleanDistribar();
                            },
                            icon: const Icon(
                              Icons.water_drop_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
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
                              icon: const Icon(Icons.circle),
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
                              icon: const Icon(Icons.circle),
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
                              icon: const Icon(Icons.circle),
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
                              icon: const Icon(Icons.circle),
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
                              icon: const Icon(Icons.circle),
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
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 15, right: 15, left: 15),
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              MyColors.bluePale),
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
                );
              } else {
                return const NoDistribarFound();
              }
            }
          },
        ),
      ),
    );
  }

  void _attributeSelectionedBottle(int location) async {
    setState(() {
      selectedBottle = location;
    });

    final snapshot = await ref.child('$idDistribar/config/gpio$location').get();
    if (snapshot.value == null) {
      _alcoholController.text = "";
    } else {
      _alcoholController.text = snapshot.value.toString();
    }

    int selectedId =
        _listAlcohol.values.toList().indexOf(snapshot.value.toString());
    _selectedAlcohol[0] = selectedId;
  }

  void _saveBottle() {
    String selectedAlcohol = _listAlcohol.values.elementAt(_selectedAlcohol[0]);

    ref
        .child('$idDistribar/config')
        .update({"gpio$selectedBottle": selectedAlcohol});
  }

  Future<void> _confirmCleanDistribar() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return _confirmationDialog(context);
      },
    );
  }
  AlertDialog _confirmationDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Êtes-vous sûr de vouloir lancer un nettoyage pour votre distribar ?",
      ),
      content: const Text("Pensez à mettre de l'eau dans toutes les bouteilles"),
      actions: [
        TextButton(
          onPressed: () {
            _setCleanDistribar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Nettoyage en cours..."),
                backgroundColor: Colors.greenAccent,
              ),
            );
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          child: const Text("Confirmer"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          child: const Text("Annuler"),
        ),
      ],
      elevation: 24.0,
      backgroundColor: MyColors.bluePale,
      contentTextStyle: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  void _setCleanDistribar() {
    ref.child(idDistribar).update({"nettoyage": 1});
  }
}
