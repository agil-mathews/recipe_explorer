import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/viewmodel/favourites_provider.dart';
import 'package:recipe_explorer/views/widgets/mealcard.dart';



class FavoritesScreen
    extends ConsumerWidget {

  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {

    final favorites =
        ref.watch(favoritesProvider);

    return Scaffold(

      backgroundColor:
          const Color(0xFFFDF8F6),

      appBar: AppBar(
        title: const Text(
          'My Favorites',
        ),
        centerTitle: true,
      ),

      body: favorites.isEmpty

          /// EMPTY STATE
          ? Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [

                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color:
                        Colors.grey.shade400,
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'No Favorites Yet',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    'Recipes you like will appear here',
                    style: TextStyle(
                      color: Colors
                          .grey.shade600,
                    ),
                  ),
                ],
              ),
            )

          /// FAVORITES GRID
          : GridView.builder(

              padding:
                  const EdgeInsets.all(
                20,
              ),

              itemCount:
                  favorites.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing:
                    16,

                mainAxisSpacing:
                    16,

                childAspectRatio:
                    0.72,
              ),

              itemBuilder:
                  (context, index) {

                final meal =
                    favorites[index];

                return MealCard(
  meal: meal,
);
              },
            ),
    );
  }
}

 