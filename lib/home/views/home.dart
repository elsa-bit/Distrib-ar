import 'package:distribar/cocktail/cocktail.dart';
import 'package:distribar/config/config_screen.dart';
import 'package:distribar/favorite/views/favorite_screen.dart';
import 'package:distribar/home/views/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  final screens = [
    Config(),
    Cocktail(),
    Favorite(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        setIndexOfButton: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
