import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meal.dart';

class ApiService {
  static const baseUrl = "https://www.themealdb.com/api/json/v1/1";

  // Search vegetarian meals by name
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/search.php?s=$query"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      // Filter only vegetarian meals
      final vegMeals = meals.where((m) => m['strCategory'] == 'Vegetarian').toList();
      return vegMeals.map((m) => Meal.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load vegetarian meals");
    }
  }

  // Get vegetarian meal details by ID
  static Future<Map<String, dynamic>> getMealDetails(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meal = data['meals'][0];
      if (meal['strCategory'] == 'Vegetarian') {
        return meal;
      } else {
        throw Exception("Meal is not vegetarian");
      }
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

  // Get vegetarian meals by ingredient
  static Future<List> getVegetarianMealsByIngredient(String ingredient) async {
    final response = await http.get(Uri.parse("$baseUrl/filter.php?i=$ingredient"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      // Filter only vegetarian meals
      final vegMeals = [];
      for (var m in meals) {
        final details = await getMealDetails(m['idMeal']);
        if (details['strCategory'] == 'Vegetarian') {
          vegMeals.add(Meal.fromJson(details));
        }
      }
      return vegMeals;
    } else {
      throw Exception("Failed to load meals by ingredient");
    }
  }

  // Get all vegetarian meals
  static Future<List<Meal>> getAllVegetarianMeals() async {
    final response = await http.get(Uri.parse("$baseUrl/filter.php?c=Vegetarian"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => Meal.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load vegetarian meals");
    }
  }
}
