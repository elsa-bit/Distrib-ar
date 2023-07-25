import 'package:distribar/utils/MyColors.dart';
import 'package:flutter/material.dart';

class NoDistribarFound extends StatelessWidget {
  const NoDistribarFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Image.asset("assets/images/no_distribar_found.png"),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 25.0, left: 30),
          child: Text(
              "Pas de Distribar detectée",
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: MyColors.blueDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 32),
            ),
          ),
      ],
    );
  }
}
