import 'package:flutter_riverpod/legacy.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/viewmodel/meal_provider.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Meal>>(
  (ref) => FavoritesNotifier(ref.read(mealRepositoryProvider)),
);

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  final dynamic repository;

  FavoritesNotifier(this.repository) : super([]) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favorites = await repository.getFavorites();

    state = favorites;
  }

  Future<void> toggleFavorite(Meal meal) async {
    final updatedFavorites = [...state];

    final exists = updatedFavorites.any((item) => item.id == meal.id);

    if (exists) {
      updatedFavorites.removeWhere((item) => item.id == meal.id);
    } else {
      updatedFavorites.add(meal);
    }

    state = updatedFavorites;

    await repository.saveFavorites(updatedFavorites);
  }

  bool isFavorite(String mealId) {
    return state.any((meal) => meal.id == mealId);
  }
}
