import 'package:distribar/ancien_projet/utils/MyColors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) setIndexOfButton;

  const BottomNavBar({Key? key, required this.setIndexOfButton})
      : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedItem = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      widget.setIndexOfButton(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: MyColors.blueFonce),
        ),
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.liquor,
              ),
              label: 'Alcohol present'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_bar,
              ),
              label: 'Cocktail'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_rounded,
              ),
              label: 'Favorites'),
        ],
        currentIndex: _selectedItem,
        unselectedItemColor: MyColors.blueFonce,
        selectedItemColor: MyColors.bluePale,
        onTap: _onItemTapped,
      ),
    );
  }
}
