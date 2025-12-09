/// Model for weather history entry stores basic weather info for a searched city
class HistoryModel {
  final String city;
  final double temp;
  final String description;
  final String icon;
  final DateTime time;

  HistoryModel({
    required this.city,
    required this.temp,
    required this.description,
    required this.icon,
    required this.time,
  });
}