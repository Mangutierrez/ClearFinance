import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clear_finance/model/goal_model.dart';

class GoalData {
  static List<GoalModel> goals = [];

  static Future<void> loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final String? goalsString = prefs.getString('goals');
    if (goalsString != null) {
      final List<dynamic> goalsJson = jsonDecode(goalsString);
      goals = goalsJson.map((json) => GoalModel.fromJson(json)).toList();
    }
  }

  static Future<void> saveGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final String goalsString = jsonEncode(goals.map((goal) => GoalModel.toJson(goal)).toList());
    prefs.setString('goals', goalsString);
  }

  static void addGoal(GoalModel goal) {
    goals.add(goal);
    saveGoals();
  }

  static void removeGoal(GoalModel goal) {
    goals.remove(goal);
    saveGoals();
  }
}
