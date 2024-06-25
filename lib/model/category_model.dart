import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final Color backgroundColor;
  final String type;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.backgroundColor,
    required this.type,
  });

  static Map<String, dynamic> toJson(CategoryModel model) {
    return {
      'name': model.name,
      'icon': model.icon.codePoint,
      'backgroundColor': model.backgroundColor.value,
      'type': model.type,
    };
  }

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      backgroundColor: Color(json['backgroundColor']),
      type: json['type'],
    );
  }
}
