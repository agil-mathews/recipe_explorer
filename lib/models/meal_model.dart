class IngredientMeasure {
  final String ingredient;
  final String measure;

  const IngredientMeasure({
    required this.ingredient,
    required this.measure,
  });
}

class Meal {
  final String id;
  final String name;
  final String thumbUrl;
  final String? category;
  final String? area;
  final String? instructions;
  final String? tags;
  final String? youtubeUrl;
  final List<IngredientMeasure>? ingredients;

  const Meal({
    required this.id,
    required this.name,
    required this.thumbUrl,
    this.category,
    this.area,
    this.instructions,
    this.tags,
    this.youtubeUrl,
     this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    final ingredientsList = <IngredientMeasure>[];

    // Loop through the 20 potential ingredient/measure fields in MealDB response
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredientsList.add(
          IngredientMeasure(
            ingredient: ingredient.trim(),
            measure: (measure != null && measure.trim().isNotEmpty)
                ? measure.trim()
                : '',
          ),
        );
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbUrl: json['strMealThumb'] ?? '',
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      tags: json['strTags'],
      youtubeUrl: json['strYoutube'],
      ingredients: ingredientsList,
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strMealThumb': thumbUrl,
    };
  }
}
