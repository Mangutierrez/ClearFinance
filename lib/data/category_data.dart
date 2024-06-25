import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clear_finance/model/category_model.dart';

class CategoryData {
  static List<CategoryModel> categories = [];

  static Future<void> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? categoriesString = prefs.getString('categories');
    if (categoriesString != null) {
      final List<dynamic> categoriesJson = jsonDecode(categoriesString);
      categories = categoriesJson.map((json) => CategoryModel.fromJson(json)).toList();
    }
  }

  static Future<void> saveCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String categoriesString = jsonEncode(categories.map((category) => CategoryModel.toJson(category)).toList());
    prefs.setString('categories', categoriesString);
  }

  static void addCategory(CategoryModel category) {
    categories.add(category);
    saveCategories();
  }

  static void removeCategory(CategoryModel category) {
    categories.remove(category);
    saveCategories();
  }
}
