import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_explorer/viewmodel/search_provider.dart';
import 'package:recipe_explorer/views/widgets/errorview.dart';
import 'package:recipe_explorer/views/widgets/loading%20indicator.dart';
import 'package:recipe_explorer/views/widgets/mealcard.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchMealsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Search Meals")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              onChanged: (value) {
                ref.read(searchMealsProvider.notifier).search(value);
              },
              decoration: InputDecoration(
                hintText: "Search meal name...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 📋 Results
            Expanded(
              child: searchState.when(
                data: (meals) {
                  if (meals.isEmpty) {
                    return const Center(child: Text("No results found"));
                  }

                  return ListView.separated(
                    itemCount: meals.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),

                    itemBuilder: (context, index) {
                      return MealCard(meal: meals[index]);
                    },
                  );
                },
                loading: () => const LoadingView(message: "Searching meals..."),
                error: (e, _) => ErrorView(
                  message: e.toString(),
                  onRetry: () {
                    ref.refresh(searchMealsProvider);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
