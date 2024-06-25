import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clear_finance/model/history_model.dart';

class HistoryData {
  static List<HistoryModel> history = [];

  static Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyString = prefs.getString('history');
    if (historyString != null) {
      final List<dynamic> historyJson = jsonDecode(historyString);
      history = historyJson.map((json) => HistoryModel.fromJson(json)).toList();
    }
  }

  static Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String historyString = jsonEncode(history.map((history) => HistoryModel.toJson(history)).toList());
    prefs.setString('history', historyString);
  }

  static void addHistory(HistoryModel historyItem) {
    history.add(historyItem);
    saveHistory();
  }

  static void removeHistory(HistoryModel historyItem) {
    history.remove(historyItem);
    saveHistory();
  }
}
