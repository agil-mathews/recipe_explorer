import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_explorer/viewmodel/home_viewmodel.dart';
import 'package:recipe_explorer/views/search.dart';
import 'package:recipe_explorer/views/widgets/categorycard.dart';
import 'package:recipe_explorer/views/widgets/errorview.dart';
import 'package:recipe_explorer/views/widgets/loading%20indicator.dart';
import 'package:recipe_explorer/views/widgets/mealcard.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final categoriesAsync = ref.watch(categoriesProvider);

    final mealsAsync = ref.watch(mealsByCategoryProvider);

    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F6),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(categoriesProvider);
            ref.refresh(mealsByCategoryProvider);
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),

            slivers: [
              /// HEADER
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.menu, color: Colors.brown.shade700),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recipe Explorer',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown.shade800,
                              ),
                            ),
                            Text(
                              'Hello, Chef Gourmet',
                              style: TextStyle(color: Colors.brown.shade400),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchPage(),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.orange.shade100,
                          child: const Icon(
                            Icons.search,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 110,
                  child: categoriesAsync.when(
                    data: (categories) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedCategory == category.name;

                          return GestureDetector(
                            onTap: () {
                              ref
                                      .read(selectedCategoryProvider.notifier)
                                      .state =
                                  category.name;
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: CategoryCard(
                                name: category.name,
                                imageUrl: category.thumbnail, // IMPORTANT
                                isSelected: isSelected,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const LoadingView(message: "Loading..."),
                    error: (e, _) => ErrorView(
                      message: e.toString(),
                      onRetry: () {
                        ref.refresh(categoriesProvider);
                      },
                    ),
                  ),
                ),
              ),

              /// TITLE
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending Recipes',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                        ),
                      ),
                      // Text(
                      //   'View all',
                      //   style: TextStyle(
                      //     color: Colors.deepOrange,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),

              /// MEALS GRID
              mealsAsync.when(
                data: (meals) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.72,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final meal = meals[index];

                        return MealCard(meal: meal);
                      }, childCount: meals.length),
                    ),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300,
                    child: LoadingView(message: "Loading..."),
                  ),
                ),
                error: (e, _) => SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300,
                    child: ErrorView(
                      message: e.toString(),
                      onRetry: () {
                        ref.refresh(mealsByCategoryProvider);
                      },
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
