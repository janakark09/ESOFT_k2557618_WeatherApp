// ========================== Model class for forecast =====================================
class ForecastModel {
  final String date;
  final double temp;
  final String description;
  final String icon;   // Icon code for the weather condition ------------------------

  // ------------------- constructor -------------
  ForecastModel({
    required this.date,
    required this.temp,
    required this.description,
    required this.icon,
  });

  // -------- Factory constructor to parse JSON and create a ForecastModel object ------------
  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: json['dt_txt'],
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
