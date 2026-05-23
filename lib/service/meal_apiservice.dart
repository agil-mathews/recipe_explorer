import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recipe_explorer/models/meal_model.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

class MealApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  /// COMMON GET REQUEST METHOD
  Future<dynamic> _getRequest(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/$endpoint'))
          .timeout(const Duration(seconds: 10));

      // log('API URL: $_baseUrl/$endpoint');
      // log('STATUS CODE: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw ApiException('Server error (${response.statusCode})');
      }
    }
    /// NO INTERNET
    on SocketException {
      throw ApiException('No internet connection');
    }
    /// TIMEOUT
    on TimeoutException {
      throw ApiException('Request timeout. Please try again.');
    }
    /// UNKNOWN
    catch (e) {
      throw ApiException('Something went wrong');
    }
  }

  /// GET CATEGORIES
  Future<List<dynamic>> getCategories() async {
    final data = await _getRequest('categories.php');

    return data['categories'] ?? [];
  }

  /// GET MEALS BY CATEGORY
  Future<List<dynamic>> getMealsByCategory(String category) async {
    final data = await _getRequest('filter.php?c=$category');

    return data['meals'] ?? [];
  }

  /// GET MEAL DETAIL
  Future<Map<String, dynamic>> getMealDetail(String id) async {
    final data = await _getRequest('lookup.php?i=$id');

    return data['meals'][0];
  }

  /// SEARCH MEALS
  Future<List<Meal>> searchMeals(String query) async {
    final data = await _getRequest('search.php?s=$query');

    if (data['meals'] == null) {
      return [];
    }

    final List meals = data['meals'];

    return meals.map((e) => Meal.fromJson(e)).toList();
  }
}
