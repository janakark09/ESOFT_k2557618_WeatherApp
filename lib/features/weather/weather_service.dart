import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/masters/api_masters.dart';
// Service class for making weather API requests.
class ApiService {
  // Calls the OpenWeatherMap "current weather" API
  Future<Map<String, dynamic>> getWeatherByCity(String city) async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}weather?q=$city&appid=${ApiConstants.apiKey}&units=metric'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
