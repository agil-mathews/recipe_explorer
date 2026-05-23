import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/viewmodel/favourites_provider.dart';
import 'package:recipe_explorer/views/meal_detailedscreen.dart';

class MealCard extends ConsumerWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref
        .watch(favoritesProvider)
        .any((item) => item.id == meal.id);

    return GestureDetector(
      onTap: () {
              Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              RecipeDetailScreen(
            mealId: meal.id,
          ),
        ),
      );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
      
        child: Stack(
          fit: StackFit.expand,
      
          children: [
            /// IMAGE
            Image.network(meal.thumbUrl, fit: BoxFit.cover),
      
            /// DARK GRADIENT
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.75), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
      
            /// FAVORITE BUTTON
            Positioned(
              top: 12,
              right: 12,
              child: CircleAvatar(
                backgroundColor: Colors.white24,
      
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
      
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
      
                  onPressed: () {
                    ref.read(favoritesProvider.notifier).toggleFavorite(meal);
                  },
                ),
              ),
            ),
      
            /// TITLE + CATEGORY
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
      
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
      
                    decoration: BoxDecoration(
                      color: Colors.white24,
      
                      borderRadius: BorderRadius.circular(20),
                    ),
      
                    child: Text(
                      meal.category ?? 'Recipe',
      
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
      
                  const SizedBox(height: 10),
      
                  Text(
                    meal.name,
      
                    maxLines: 2,
      
                    overflow: TextOverflow.ellipsis,
      
                    style: const TextStyle(
                      color: Colors.white,
      
                      fontSize: 20,
      
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
