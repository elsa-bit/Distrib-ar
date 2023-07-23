import 'package:distribar/details/views/detail_cocktail.dart';
import 'package:distribar/utils/MyColors.dart';
import 'package:flutter/material.dart';

class ItemCardCocktail extends StatelessWidget {
  final String? cocktailId;
  final String? cocktailTitle;
  final String? urlImage;

  const ItemCardCocktail({
    Key? key,
    required this.cocktailId,
    required this.cocktailTitle,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: FractionallySizedBox(
        widthFactor: 0.85,
        child: Container(
          height: 200,
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return Detail(id: cocktailId);
                        },
                      ),
                    );
                  },
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
                      Align(
                        heightFactor: 5.6,
                        alignment: Alignment.bottomRight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: 50,
                            height: 15,
                            alignment: Alignment.center,
                            color: MyColors.bluePale,
                            child: const Text(
                              "Distrib'ar",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
    );
  }
}
