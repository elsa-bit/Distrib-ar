import 'package:distribar/ancien_projet/utils/MyColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
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
                ],
              ),
            ),
          ),
          Stack(
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
                  color: selectedBottle == 2 ? MyColors.bluePale : MyColors.greyConfig,
                  iconSize: 60,
                ),
              ),
              Positioned(
                top: 20,
                right: -10,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _attributeSelectionedBottle(3);
                    });
                  },
                  icon: Icon(Icons.circle),
                  color: selectedBottle == 3 ? MyColors.bluePale : MyColors.greyConfig,
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
                  color: selectedBottle == 1 ? MyColors.bluePale : MyColors.greyConfig,
                  iconSize: 60,
                ),
              ),
              Positioned(
                bottom: 40,
                right: -10,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _attributeSelectionedBottle(4);
                    });
                  },
                  icon: Icon(Icons.circle),
                  color: selectedBottle == 4 ? MyColors.bluePale : MyColors.greyConfig,
                  iconSize: 60,
                ),
              ),
            ],
          ),
          const Text(
            'Choisissez la boisson présente à l’emplacement \n choisi',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(bottom: 25, right: 15, left: 15),
            child: TextField(
              controller: _alcoholController,
              decoration: const InputDecoration(
                labelText: "L'alcool",
              ),
            ),
          ),
          const SizedBox(height: 10),
          IntrinsicWidth(
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(MyColors.bluePale),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.close, color: Colors.white, size: 18),
                  SizedBox(width: 5),
                  Text(
                    'Enlever',
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
    );
  }

  void _attributeSelectionedBottle(int location) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    selectedBottle = location;
    idDistribar = prefs.getString('id_Distribar') ?? '';

    //REGARDER POUR RECUP LES INFOS DU DISTRIBAR
    DatabaseReference ref = FirebaseDatabase.instance.ref(idDistribar);
    await ref.set({
      "config": {
        "gpio1": "vodka",
        "gpio2": "",
        "gpio3": "applejuice",
        "gpio4": "gin",
        "gpio5": "",
      }
    });

    _alcoholController.text = "Coucou";
  }
}
