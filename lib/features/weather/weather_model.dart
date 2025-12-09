// Model for current weather data for a city
class WeatherModel {
  final String cityName;
  final double temp;
  final String description;
  final String icon; // Icon code for weather condition

  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.description,
    required this.icon,
  });
// -------------- Create WeatherModel from JSON response ----------------------
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
