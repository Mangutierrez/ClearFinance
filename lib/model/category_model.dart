import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final Color backgroundColor;
  final String type;

  CategoryModel(
      {required this.name,
      required this.icon,
      required this.backgroundColor,
      required this.type});
}
