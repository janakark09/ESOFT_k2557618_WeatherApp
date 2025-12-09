import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/masters/api_masters.dart';

// Service class for calling the forecast API
class ForecastService {
  // Fetches forecast for a city and returns raw JSON list
  Future<List<dynamic>> getForecastByCity(String city) async {
    final response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}forecast?q=$city&appid=${ApiConstants.apiKey}&units=metric'));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['list'];
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
