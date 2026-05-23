import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_explorer/models/meal_detailedmodel.dart';
import 'package:recipe_explorer/service/meal_apiservice.dart';
import '../repository/meal_repository.dart';

final mealApiServiceProvider = Provider<MealApiService>((ref) {
  return MealApiService();
});

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  final apiService = ref.watch(mealApiServiceProvider);
  return MealRepository(apiService);
});

final mealDetailProvider = FutureProvider.family<MealDetail, String>((
  ref,mealId,
) async {
  final repository = ref.read(mealRepositoryProvider);

  return repository.getMealDetail(mealId);
});
