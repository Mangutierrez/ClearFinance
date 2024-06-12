import 'package:clear_finance/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryData {
  static List<CategoryModel> categories = [
    CategoryModel(
        name: 'Comida',
        icon: Icons.fastfood,
        backgroundColor: const Color(0xFFBA7423),
        type: 'Gasto'),
  ];
}
