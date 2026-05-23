import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class MealApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<dynamic>> getCategories() async {
        log('Fetching categories from API... service layer');

    final response = await http.get(Uri.parse('$_baseUrl/categories.php'));
    log('response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      log(  'Categories API response: ${response.body}');
      final data = json.decode(response.body);
      return data['categories'] ?? [];
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<dynamic>> getMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$_baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] ?? [];
    } else {
      throw Exception('Failed to load meals for category $category');
    }
  }

  Future<List<dynamic>> searchMeals(String query) async {
    // URL-encode the search query to handle spaces and special characters
    final encodedQuery = Uri.encodeComponent(query);
    final response = await http.get(Uri.parse('$_baseUrl/search.php?s=$encodedQuery'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] ?? [];
    } else {
      throw Exception('Failed to search meals for query $query');
    }
  }

  Future<Map<String, dynamic>?> getMealDetails(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final meals = data['meals'] as List?;
      if (meals != null && meals.isNotEmpty) {
        return meals.first as Map<String, dynamic>;
      }
      return null;
    } else {
      throw Exception('Failed to load meal details for id $id');
    }
  }

  Future<Map<String, dynamic>?> getRandomMeal() async {
    final response = await http.get(Uri.parse('$_baseUrl/random.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final meals = data['meals'] as List?;
      if (meals != null && meals.isNotEmpty) {
        return meals.first as Map<String, dynamic>;
      }
      return null;
    } else {
      throw Exception('Failed to load random meal');
    }
  }
}
