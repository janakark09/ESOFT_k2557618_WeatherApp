import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './forecast_provider.dart';
// Screen displaying the forecast for a selected city
class ForecastScreen extends StatefulWidget {
  final String city;
  const ForecastScreen({super.key, required this.city});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch forecast when screen is initialized
    Provider.of<ForecastProvider>(context, listen: false)
        .fetchForecast(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forecast (${widget.city})"),
      ),
      body: Consumer<ForecastProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.forecast.isEmpty) {
            return const Center(child: Text("No forecast available"));
          }

          return ListView.builder(
            itemCount: provider.forecast.length,
            itemBuilder: (context, index) {
              final item = provider.forecast[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  //displaying the weather icon from the openweathermap.org
                  leading: Image.network(
                    "https://openweathermap.org/img/wn/${item.icon}@2x.png",
                  ),
                  title: Text("${item.temp}°C — ${item.description}"),
                  subtitle: Text(item.date),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
