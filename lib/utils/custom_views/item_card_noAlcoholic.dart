import 'package:distribar/details/views/detail_cocktail.dart';
import 'package:distribar/utils/MyColors.dart';
import 'package:flutter/material.dart';

class ItemCardNoAlcoholic extends StatelessWidget {
  final String? cocktailTitle;
  final String? urlImage;
  final String? id;


  const ItemCardNoAlcoholic( {
    Key? key,
    required this.cocktailTitle,
    required this.urlImage,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Detail(id : id);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.blueFonce,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                /** Cocktail image with alcoholic indication **/
                Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 90,
                  child: Stack(
                    children: [
                      urlImage != null
                          ? Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(35),
                            child: Image.network(urlImage!),
                          ),
                        ),
                      )
                          : Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(35),
                            child: Image.asset(
                                'assets/images/exemple_cocktail.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /** Cocktail title **/
                cocktailTitle != null
                    ? Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      cocktailTitle!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Prompt',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.only(left: 7, top: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "N/A",
                      style: TextStyle(
                          fontFamily: 'Prompt',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
