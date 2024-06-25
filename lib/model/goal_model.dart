import 'package:flutter/material.dart';

class GoalModel {
  final String name;
  final double amount;
  final String category;
  final DateTime date;
  final Color categoryColor;

  GoalModel({
    required this.name,
    required this.amount,
    required this.category,
    required this.date,
    required this.categoryColor,
  });

  static Map<String, dynamic> toJson(GoalModel model) {
    return {
      'name': model.name,
      'amount': model.amount,
      'category': model.category,
      'date': model.date.toIso8601String(),
      'categoryColor': model.categoryColor.value,
    };
  }

  static GoalModel fromJson(Map<String, dynamic> json) {
    return GoalModel(
      name: json['name'],
      amount: json['amount'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      categoryColor: Color(json['categoryColor']),
    );
  }
}
