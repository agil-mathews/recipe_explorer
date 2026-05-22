import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/viewmodel/meal_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoritesNotifier extends StateNotifier<List<String>> {
  static const String _prefsKey = 'favorite_meal_ids';

  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedIds = prefs.getStringList(_prefsKey);
      if (savedIds != null) {
        state = savedIds;
      }
    } catch (e) {
      // Handle SharedPreferences platform exceptions gracefully
      state = [];
    }
  }

  Future<void> toggleFavorite(String mealId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final updatedList = List<String>.from(state);

      if (updatedList.contains(mealId)) {
        updatedList.remove(mealId);
      } else {
        updatedList.add(mealId);
      }

      state = updatedList;
      await prefs.setStringList(_prefsKey, updatedList);
    } catch (e) {
      // Fail gracefully on errors
    }
  }

  bool isFavorite(String mealId) {
    return state.contains(mealId);
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier();
});

// A provider that fetches full Meal objects in parallel for the list of favorited IDs
final favoriteMealsProvider = FutureProvider<List<Meal>>((ref) async {
  final favoriteIds = ref.watch(favoritesProvider);
  final repository = ref.watch(mealRepositoryProvider);

  if (favoriteIds.isEmpty) return [];

  // Fetch details for all favorited IDs in parallel to avoid sequential network delays
  final futures = favoriteIds.map((id) => repository.fetchMealDetails(id));
  final results = await Future.wait(futures);

  // Filter out any null responses or errors and cast as a solid List<Meal>
  return results.whereType<Meal>().toList();
});
