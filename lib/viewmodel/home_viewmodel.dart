import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:recipe_explorer/models/category_model.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/viewmodel/meal_provider.dart';

/// SELECTED CATEGORY

final selectedCategoryProvider = StateProvider<String>((ref) => 'Beef');

/// CATEGORIES

final categoriesProvider = FutureProvider<List<MealCategory>>((ref) async {
  final repository = ref.read(mealRepositoryProvider);

  return repository.fetchCategories();
});

/// MEALS BY CATEGORY

final mealsByCategoryProvider = FutureProvider<List<Meal>>((ref) async {
  final category = ref.watch(selectedCategoryProvider);

  final repository = ref.read(mealRepositoryProvider);

  return repository.fetchMealsByCategory(category);
});
