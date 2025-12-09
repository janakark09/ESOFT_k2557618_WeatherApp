import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './history_provider.dart';

// ============================== Screen to displays a list of previously searched weather results===========================

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather History")),
      // ----------------------- Using Consumer to update UI when history changes ---------------------------------
      body: Consumer<HistoryProvider>(
        builder: (context, provider, child) {
          // ------ Show message if no history entries -------------
          if (provider.history.isEmpty) {
            return const Center(
              child: Text("No history available"),
            );
          }
// List of previously searched weather results
          return ListView.builder(
            itemCount: provider.history.length,
            itemBuilder: (context, index) {
              final item = provider.history[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(
                    "https://openweathermap.org/img/wn/${item.icon}@2x.png",
                  ),
                  title: Text("${item.city} - ${item.temp}°C"),
                  subtitle: Text(
                    "${item.description}\n${item.time}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
