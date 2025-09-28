import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meal.dart';

class ApiService {
  static const baseUrl = "https://www.themealdb.com/api/json/v1/1";

  // Search meals by name (all categories)
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/search.php?s=$query"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => Meal.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load meals");
    }
  }

  // Get meal details by ID
  static Future<Map<String, dynamic>> getMealDetails(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['meals'][0];
    } else {
      throw Exception("Failed to load meal details");
    }
  }

  // Get list of ingredients
  static Future<List<String>> getIngredients() async {
    final response = await http.get(Uri.parse("$baseUrl/list.php?i=list"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['meals'] ?? [];
      return list.map((item) => item['strIngredient'] as String).toList();
    } else {
      throw Exception("Failed to load ingredients");
    }
  }

  // Get meals by ingredient
  static Future<List<Meal>> getMealsByIngredient(String ingredient) async {
    final response = await http.get(Uri.parse("$baseUrl/filter.php?i=$ingredient"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => Meal.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load meals by ingredient");
    }
  }

  // Get all meals by category (Veg or Non-Veg)
  static Future<List<Meal>> getMealsByCategory(String categoryName) async {
    final response = await http.get(Uri.parse("$baseUrl/filter.php?c=$categoryName"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => Meal.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load meals for $categoryName");
    }
  }

  // Get all meal categories
  static Future<List<dynamic>> getCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories.php"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['categories'] ?? [];
    } else {
      throw Exception("Failed to load categories");
    }
  }

  // Get latest meals
  static Future<List<Meal>> getLatestMeals() async {
    final response = await http.get(Uri.parse("$baseUrl/latest.php"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => Meal.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load latest meals");
    }
  }

  // Get random meal (for banner)
  static Future<Map<String, dynamic>> getRandomMeal() async {
    final response = await http.get(Uri.parse("$baseUrl/random.php"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['meals'][0];
    } else {
      throw Exception("Failed to load random meal");
    }
  }
}
