import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/service/meal_apiservice.dart';

final mealServiceProvider = Provider((ref) => MealApiService());

final searchMealsProvider =
    StateNotifierProvider<SearchMealsNotifier, AsyncValue<List<Meal>>>(
  (ref) => SearchMealsNotifier(ref),
);

final searchQueryProvider = StateProvider<String>((ref) => "");
class SearchMealsNotifier extends StateNotifier<AsyncValue<List<Meal>>> {
  SearchMealsNotifier(this.ref) : super(const AsyncValue.data([]));

  final Ref ref;
  Timer? _debounce;

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        state = const AsyncValue.data([]);
        return;
      }

      state = const AsyncValue.loading();

      try {
        final results =
            await ref.read(mealServiceProvider).searchMeals(query);

        state = AsyncValue.data(results);
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    });
  }

  void clear() {
    _debounce?.cancel();
    state = const AsyncValue.data([]);
  }
}