

import 'package:recipe_explorer/models/category_model.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/service/meal_apiservice.dart';

class MealRepository {
  final MealApiService _apiService;

  MealRepository(this._apiService);

  Future<List<MealCategory>> fetchCategories() async {
    final rawCategories = await _apiService.getCategories();
    return rawCategories.map((json) => MealCategory.fromJson(json)).toList();
  }

  Future<List<Meal>> fetchMealsByCategory(String categoryName) async {
    final rawMeals = await _apiService.getMealsByCategory(categoryName);
    return rawMeals.map((json) => Meal.fromJson(json)).toList();
  }

  Future<List<Meal>> searchMeals(String query) async {
    final rawMeals = await _apiService.searchMeals(query);
    return rawMeals.map((json) => Meal.fromJson(json)).toList();
  }

  Future<Meal?> fetchMealDetails(String id) async {
    final rawMeal = await _apiService.getMealDetails(id);
    if (rawMeal != null) {
      return Meal.fromJson(rawMeal);
    }
    return null;
  }

  Future<Meal?> fetchRandomMeal() async {
    final rawMeal = await _apiService.getRandomMeal();
    if (rawMeal != null) {
      return Meal.fromJson(rawMeal);
    }
    return null;
  }
}
