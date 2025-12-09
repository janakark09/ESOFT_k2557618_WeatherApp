import 'package:flutter/material.dart';
import './forecast_model.dart';
import './forecast_service.dart';

/// handling forecast business logic and fetches weather forecast from API
class ForecastProvider with ChangeNotifier {

  // List storing forecast data.
  List<ForecastModel> _forecast = [];
  List<ForecastModel> get forecast => _forecast;
  // Indicates loading state
  bool _loading = false;
  bool get loading => _loading;

  final ForecastService _service = ForecastService();
// Retrive forecast data for a given city
  Future<void> fetchForecast(String city) async {
    try {
      _loading = true;
      notifyListeners();

      final data = await _service.getForecastByCity(city);
// Convert raw API list into ForecastModel list
      _forecast = data
          .map<ForecastModel>((item) => ForecastModel.fromJson(item))
          .toList();

      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      throw Exception("Error: $e");
    }
  }
}
