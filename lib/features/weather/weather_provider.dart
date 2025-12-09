import 'package:flutter/material.dart';
import './weather_model.dart';
import 'weather_service.dart';

// ============== managing weather API calls and app state =======================
class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;
  // -------------- Current weather data ----------------------------------
  WeatherModel? get weather => _weather;

  bool _isLoading = false;
  // ----------Indicates whether weather data is being fetched
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();
//=================================================== current weather for a city ===========================================
  Future<void> getWeather(String city) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _apiService.getWeatherByCity(city);
      //-------------------------------  Parse the API response into WeatherModel ----------
      _weather = WeatherModel.fromJson(data);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Error fetching weather: $e');
    }
  }
}
