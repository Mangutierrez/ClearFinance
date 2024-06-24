import 'package:flutter/material.dart';

class HistoryModel {
  final String date;
  final String category;
  final String type;
  final String description;
  final String amount;
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
}
