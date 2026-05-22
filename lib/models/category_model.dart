class MealCategory {
  final String id;
  final String name;
  final String thumbUrl;
  final String description;

  const MealCategory({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.description,
  });

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      id: json['idCategory'] ?? '',
      name: json['strCategory'] ?? '',
      thumbUrl: json['strCategoryThumb'] ?? '',
      description: json['strCategoryDescription'] ?? '',
    );
  }
}
