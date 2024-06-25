

import 'package:clear_finance/data/category_data.dart';
import 'package:clear_finance/data/goal_data.dart';
import 'package:flutter/material.dart';
import 'package:clear_finance/screen/welcome_screen.dart';

import 'data/history_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CategoryData.loadCategories();
  await HistoryData.loadHistory();
  await GoalData.loadGoals();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClearFinance',
      debugShowCheckedModeBanner: false,
      locale: const Locale('es', ''),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}
