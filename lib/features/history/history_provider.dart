import 'package:flutter/material.dart';
import './history_model.dart';

// Provider to store and manage a list of previously searched weather data ============================================================
// -------------------- This is a history log (not permanently) -------------------------------------
class HistoryProvider with ChangeNotifier {
  // Internal list of weather history entries
  final List<HistoryModel> _history = [];
  // getter to history list
  List<HistoryModel> get history => _history;

  // Adds a new history entry to the list and notifies listeners
  void addToHistory(HistoryModel item) {
    _history.insert(0, item); // add newest first
    notifyListeners();
  }
}
