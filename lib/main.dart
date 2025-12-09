// Main entry point of the Weather App.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './features/weather/weather_provider.dart';
import './features/home/home_screen.dart';
import './features/forecast/forecast_provider.dart';
import './features/history/history_provider.dart';

// Sets up Providers for Weather and Forecast using MultiProvider.
void main() {
  runApp(MultiProvider(
    providers: [
  // Provider responsible for current weather
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
  // Provider responsible for forecast
      ChangeNotifierProvider(create: (_) => ForecastProvider()),
  // Provider responsible for weather history
      ChangeNotifierProvider(create: (_) => HistoryProvider()),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',

      home: const HomeScreen(title: 'Home Page'),
    );
  }
}