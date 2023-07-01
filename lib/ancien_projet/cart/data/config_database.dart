import 'dart:async';
import 'package:distribar/ancien_projet/cart/data/cart_cocktail_dao.dart';
import 'package:distribar/ancien_projet/cart/model/cart_cocktail_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'config_database.g.dart';

@Database(version: 1, entities: [CartCocktail])
abstract class AppDatabase extends FloorDatabase {
  CocktailCartDao get cartCocktailDao;
}
