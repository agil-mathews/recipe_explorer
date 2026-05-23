import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_explorer/models/meal_model.dart';
import 'package:recipe_explorer/viewmodel/favourites_provider.dart';
import 'package:recipe_explorer/viewmodel/meal_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailScreen extends ConsumerWidget {
  final String mealId;

  const RecipeDetailScreen({super.key, required this.mealId});

Future<void> launchYoutube(String url) async {
  final uri = Uri.parse(url);

  try {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    throw Exception('Could not launch video');
  }
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealAsync = ref.watch(mealDetailProvider(mealId));

    return Scaffold(
      body: mealAsync.when(
        data: (meal) {
          final isFavorite = ref
              .watch(favoritesProvider)
              .any((item) => item.id == meal.id);

          return CustomScrollView(
            slivers: [
              /// HEADER IMAGE
              SliverAppBar(
                expandedHeight: 320,

                pinned: true,

                backgroundColor: Colors.black,

                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,

                    children: [
                      Image.network(meal.image, fit: BoxFit.cover),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                actions: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,

                      color: isFavorite ? Colors.red : Colors.white,
                    ),

                    onPressed: () {
                      ref
                          .read(favoritesProvider.notifier)
                          .toggleFavorite(
                            Meal(
                              id: meal.id,
                              name: meal.name,
                              thumbUrl: meal.image,
                            ),
                          );
                    },
                  ),
                ],
              ),

              /// CONTENT
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// NAME
                      Text(
                        meal.name,

                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12),

                      /// CATEGORY + AREA
                      Row(
                        children: [
                          _InfoChip(text: meal.category),

                          const SizedBox(width: 12),

                          _InfoChip(text: meal.area),
                        ],
                      ),

                      const SizedBox(height: 32),

                      /// INGREDIENTS
                      Text(
                        'Ingredients',

                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ...meal.ingredients.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),

                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.deepOrange,
                                size: 18,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  '${item.measure} ${item.ingredient}',
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 32),

                      /// INSTRUCTIONS
                      Text(
                        'Instructions',

                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        meal.instructions,
                        style: const TextStyle(height: 1.7),
                      ),

                      const SizedBox(height: 40),

/// YOUTUBE BUTTON
SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(
    onPressed: () async {
  await launchYoutube(meal.youtubeUrl!);
},

    icon: const Icon(Icons.play_circle_fill),

    label: const Text(
      "Watch Recipe Video",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),

    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,

      foregroundColor: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
),

const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String text;

  const _InfoChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      decoration: BoxDecoration(
        color: Colors.orange.shade50,

        borderRadius: BorderRadius.circular(30),
      ),

      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
