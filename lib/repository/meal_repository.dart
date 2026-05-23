

import 'dart:developer';

import 'package:recipe_explorer/data/datasource/local/favorites_localdatasource.dart';
import 'package:recipe_explorer/models/category_model.dart';
import 'package:recipe_explorer/models/meal_detailedmodel.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/service/meal_apiservice.dart';

class MealRepository {
  final MealApiService _apiService;
  final FavoriteLocalDataSource localDataSource =
      FavoriteLocalDataSource();

  MealRepository(this._apiService);

  Future<List<MealCategory>> fetchCategories() async {
    log('Fetching categories from API... repository layer');
    final rawCategories = await _apiService.getCategories();
    return rawCategories.map((json) => MealCategory.fromJson(json)).toList();
  }

  Future<List<Meal>> fetchMealsByCategory(String categoryName) async {
    final rawMeals = await _apiService.getMealsByCategory(categoryName);
    return rawMeals.map((json) => Meal.fromJson(json)).toList();
  }

  // Future<List<Meal>> searchMeals(String query) async {
  //   final rawMeals = await _apiService.searchMeals(query);
  //   return rawMeals.map((json) => Meal.fromJson(json)).toList();
  // }



  Future<MealDetail> getMealDetail(
  String id,
) async {

  final response =
      await _apiService
          .getMealDetail(id);

  return MealDetail.fromJson(
    response,
  );
}

  // Future<Meal?> fetchRandomMeal() async {
  //   final rawMeal = await _apiService.getRandomMeal();
  //   if (rawMeal != null) {
  //     return Meal.fromJson(rawMeal);
  //   }
  //   return null;
  // }

  Future<void> saveFavorites(
  List<Meal> meals,
) async {

  await localDataSource
      .saveFavorites(meals);
}

Future<List<Meal>> getFavorites() async {

  return await localDataSource
      .getFavorites();
}
}
