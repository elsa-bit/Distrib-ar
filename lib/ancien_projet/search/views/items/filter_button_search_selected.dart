import 'package:distribar/ancien_projet/utils/MyColors.dart';
import 'package:flutter/material.dart';

class FilterButtonSearchSelected extends StatelessWidget {
  final String buttonName;

  const FilterButtonSearchSelected({
    Key? key,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        color: MyColors.blueFonce,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(color: MyColors.blueFonce),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
