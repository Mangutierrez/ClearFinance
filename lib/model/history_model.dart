import 'package:flutter/material.dart';

class HistoryModel {
  final DateTime date;
  final String category;
  final String type;
  final String description;
  final double amount;
  final Color categoryColor;
  final Color typeColor;

  HistoryModel({
    required this.date,
    required this.category,
    required this.type,
    required this.description,
    required this.amount,
    required this.categoryColor,
    required this.typeColor,
  });

  static Map<String, dynamic> toJson(HistoryModel model) {
    return {
      'date': model.date.toIso8601String(),
      'category': model.category,
      'type': model.type,
      'description': model.description,
      'amount': model.amount,
      'categoryColor': model.categoryColor.value,
      'typeColor': model.typeColor.value,
    };
  }

  static HistoryModel fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      date: DateTime.parse(json['date']),
      category: json['category'],
      type: json['type'],
      description: json['description'],
      amount: json['amount'],
      categoryColor: Color(json['categoryColor']),
      typeColor: Color(json['typeColor']),
    );
  }
}
