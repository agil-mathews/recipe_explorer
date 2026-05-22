import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:recipe_explorer/models/category_model.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/viewmodel/meal_provider.dart';


// Fetches all available food categories
final categoriesProvider = FutureProvider<List<MealCategory>>((ref) async {
  final repository = ref.watch(mealRepositoryProvider);
  return repository.fetchCategories();
});

// Holds the currently selected category name. Defaults to 'Beef'.
final selectedCategoryProvider = StateProvider<String>((ref) {
  return 'Beef';
});

// Reactive provider that fetches meals automatically based on the selectedCategoryProvider
final mealsByCategoryProvider = FutureProvider<List<Meal>>((ref) async {
  final repository = ref.watch(mealRepositoryProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  return repository.fetchMealsByCategory(selectedCategory);
});

// Fetches a random recipe for the home banner
final randomRecipeProvider = FutureProvider<Meal>((ref) async {
  final repository = ref.watch(mealRepositoryProvider);
  final meal = await repository.fetchRandomMeal();
  if (meal != null) {
    return meal;
  }
  throw Exception('Failed to load random meal');
});
