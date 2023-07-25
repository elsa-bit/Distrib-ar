import 'package:distribar/utils/MyColors.dart';
import 'package:flutter/material.dart';

class ItemCartElement extends StatelessWidget {
  final String id;
  final String? photo;
  final String name;
  final Function(bool) callback;

  const ItemCartElement(
      {Key? key,
      required this.id,
      required this.photo,
      required this.name,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(left: 15),
            child: Image.network(photo!),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: 'AlegreyaSans',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              callback(true);
            },
            child: const Icon(
              Icons.remove_circle,
              color: MyColors.blueMedium,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
