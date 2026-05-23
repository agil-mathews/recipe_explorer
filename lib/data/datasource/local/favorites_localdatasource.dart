import 'dart:convert';

import 'package:recipe_explorer/models/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteLocalDataSource {
  static const String favoriteKey = 'favorite_meals';

  Future<void> saveFavorites(List<Meal> meals) async {
    final prefs = await SharedPreferences.getInstance();

    final encodedMeals = meals.map((meal) {
      return jsonEncode(meal.toJson());
    }).toList();

    await prefs.setStringList(favoriteKey, encodedMeals);
  }

  Future<List<Meal>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteList = prefs.getStringList(favoriteKey) ?? [];

    return favoriteList.map((meal) {
      return Meal.fromJson(jsonDecode(meal));
    }).toList();
  }
}
