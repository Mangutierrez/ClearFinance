import 'package:clear_finance/model/history_model.dart';
import 'package:flutter/material.dart';

class HistoryData {
  static List<HistoryModel> history = [
    HistoryModel(
      date: 'May 25',
      category: 'Salario',
      type: 'Ingreso',
      description: 'Sueldo',
      amount: '1000.00 COP',
      categoryColor: const Color(0xFFF4BE37),
      typeColor: const Color(0xFFD64848),
    ),
    HistoryModel(
      date: 'May 25',
      category: 'Comida',
      type: 'Gasto',
      description: 'Almuerzo',
      amount: '50.00 COP',
      categoryColor: const Color(0xFF48B6D6),
      typeColor: const Color(0xFFD64848),
    ),
  ];
}
