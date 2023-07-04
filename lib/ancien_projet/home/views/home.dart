import 'package:distribar/ancien_projet/cart/views/cart_view.dart';
import 'package:distribar/ancien_projet/cocktail/cocktail.dart';
import 'package:distribar/ancien_projet/home/views/bottom_nav_bar.dart';
import 'package:distribar/config/config_screen.dart';
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
    Cart(),
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
