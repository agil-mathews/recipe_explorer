import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_explorer/viewmodel/home_viewmodel.dart';
import 'package:recipe_explorer/views/widgets/mealcard.dart';



class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final categoriesAsync =
        ref.watch(categoriesProvider);

    final mealsAsync =
        ref.watch(mealsByCategoryProvider);

    final selectedCategory =
        ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F6),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(categoriesProvider);
            ref.refresh(mealsByCategoryProvider);
          },
          child: CustomScrollView(
            physics:
                const BouncingScrollPhysics(),

            slivers: [
              /// HEADER
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.brown.shade700,
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              'Recipe Explorer',
                              style: theme
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors
                                    .brown.shade800,
                              ),
                            ),
                            Text(
                              'Hello, Chef Gourmet',
                              style: TextStyle(
                                color: Colors
                                    .brown.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      CircleAvatar(
                        backgroundColor:
                            Colors.orange.shade100,
                        child: const Icon(
                          Icons.search,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// CATEGORY LIST
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 60,
                  child: categoriesAsync.when(
                    data: (categories) {
                      return ListView.builder(
                        scrollDirection:
                            Axis.horizontal,
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 16,
                        ),
                        itemCount:
                            categories.length,
                        itemBuilder:
                            (context, index) {
                          final category =
                              categories[index];

                          final isSelected =
                              selectedCategory ==
                                  category.name;

                          return Padding(
                            padding:
                                const EdgeInsets
                                    .only(
                              right: 12,
                            ),
                            child: ChoiceChip(
                              label: Text(
                                category.name,
                              ),
                              selected:
                                  isSelected,
                              onSelected:
                                  (_) {
                                ref
                                    .read(
                                  selectedCategoryProvider
                                      .notifier,
                                )
                                    .state = category
                                        .name;
                              },
                              selectedColor:
                                  Colors
                                      .deepOrange,
                              backgroundColor:
                                  Colors
                                      .orange
                                      .shade50,
                              labelStyle:
                                  TextStyle(
                                color:
                                    isSelected
                                        ? Colors
                                            .white
                                        : Colors
                                            .brown
                                            .shade700,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  30,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(
                      child:
                          CircularProgressIndicator(),
                    ),
                    error: (e, _) =>
                        Center(
                      child: Text(
                        e.toString(),
                      ),
                    ),
                  ),
                ),
              ),

              /// TITLE
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    20,
                    24,
                    20,
                    16,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      Text(
                        'Trending Recipes',
                        style: theme
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          fontWeight:
                              FontWeight.bold,
                          color: Colors
                              .brown.shade900,
                        ),
                      ),
                      Text(
                        'View all',
                        style: TextStyle(
                          color:
                              Colors.deepOrange,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// MEALS GRID
              mealsAsync.when(
                data: (meals) {
                  return SliverPadding(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 20,
                    ),
                    sliver: SliverGrid(
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
                      delegate:
                          SliverChildBuilderDelegate(
                        (context, index) {
                          final meal =
                              meals[index];

                          return MealCard(
                            meal: meal,
                          );
                        },
                        childCount:
                            meals.length,
                      ),
                    ),
                  );
                },
                loading: () =>
                    const SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.all(40),
                    child: Center(
                      child:
                          CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (e, _) =>
                    SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      e.toString(),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


