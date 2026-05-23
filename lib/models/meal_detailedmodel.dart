class MealDetail {
  final String id;
  final String name;
  final String? alternateName;

  final String category;
  final String area;
  final String? country;

  final String instructions;

  final String image;

  final String? tags;
  final String? youtubeUrl;

  final String? sourceUrl;
  final String? imageSource;

  final String? creativeCommonsConfirmed;
  final String? dateModified;

  final List<IngredientItem> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    this.alternateName,
    required this.category,
    required this.area,
    this.country,
    required this.instructions,
    required this.image,
    this.tags,
    this.youtubeUrl,
    this.sourceUrl,
    this.imageSource,
    this.creativeCommonsConfirmed,
    this.dateModified,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    final List<IngredientItem> ingredientList = [];

    /// INGREDIENTS + MEASUREMENTS
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];

      final measure = json['strMeasure$i'];

      /// SKIP EMPTY VALUES
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredientList.add(
          IngredientItem(
            ingredient: ingredient.toString(),
            measure: measure != null ? measure.toString().trim() : '',
          ),
        );
      }
    }

    return MealDetail(
      id: json['idMeal'] ?? '',

      name: json['strMeal'] ?? '',

      alternateName: json['strMealAlternate'],

      category: json['strCategory'] ?? '',

      area: json['strArea'] ?? '',

      country: json['strCountry'],

      instructions: json['strInstructions'] ?? '',

      image: json['strMealThumb'] ?? '',

      tags: json['strTags'],

      youtubeUrl: json['strYoutube'],

      sourceUrl: json['strSource'],

      imageSource: json['strImageSource'],

      creativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],

      dateModified: json['dateModified'],

      ingredients: ingredientList,
    );
  }
}

class IngredientItem {
  final String ingredient;
  final String measure;

  IngredientItem({required this.ingredient, required this.measure});
}
