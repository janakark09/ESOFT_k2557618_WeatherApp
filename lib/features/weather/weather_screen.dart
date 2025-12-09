import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './weather_provider.dart';
import '../forecast/forecast_screen.dart';
import '../history/history_provider.dart';
import '../history/history_model.dart';
import '../history/history_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  late WeatherProvider weatherProvider;

  @override
  void initState() {
    super.initState();
    // Access provider once
    weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input city name
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter city name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 50),
            //======================================= Search weather button ==================================================
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor:Colors.black,
                  minimumSize: Size(200, 50)),
              onPressed: () async {
          // Get weather using provider
                await weatherProvider.getWeather(_controller.text);
          // If successful, add to history
                if (weatherProvider.weather != null) {
                  Provider.of<HistoryProvider>(context, listen: false).addToHistory(
                    HistoryModel(
                      city: weatherProvider.weather!.cityName,
                      temp: weatherProvider.weather!.temp,
                      description: weatherProvider.weather!.description,
                      icon: weatherProvider.weather!.icon,
                      time: DateTime.now(),
                    ),
                  );
                }
              },
              child: const Text("Search",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            //====================================== Weather result ======================================================
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const CircularProgressIndicator();
                } else if (provider.weather != null) {
                  final weather = provider.weather!;
                  return SizedBox(
                    width: w,
                    child: Column(
                      children: [
                        Text(
                          weather.cityName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${weather.temp}°C",
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          weather.description,
                          style: const TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                        // Get weather icon from the openweathermap.org
                        Image.network(
                          "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text("Loading Error of weather");
                }
              },
            ),
            //=================================== Button to view forecast ====================================================
            ElevatedButton(style:ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                foregroundColor:Colors.black),
              onPressed: () {
              if(_controller.text=="")
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a City to get the ")));
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ForecastScreen(city: _controller.text),
                    ),
                  );
                }
              },
              child: const Text("View Forecast"),
            ),
            SizedBox(height: 50),
            //=================================== Button to open Weather History Screen =============================================
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                );
              },
              child: const Text("View Weather History"),
            ),
            //===========================================================================================
          ],
        ),
      ),
    );
  }
}
