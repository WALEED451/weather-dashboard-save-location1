import 'package:flutter/material.dart';

class SavedLocationsScreen extends StatelessWidget {
  const SavedLocationsScreen({super.key});

  final List<Map<String, String>> locations = const [
    {"city": "Lahore", "temp": "30°C"},
    {"city": "Karachi", "temp": "32°C"},
    {"city": "Islamabad", "temp": "24°C"},
    {"city": "Faisalabad", "temp": "28°C"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Locations"),
        backgroundColor: const Color(0xFF0B1D4A),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
              title: Text(locations[index]["city"]!),
              subtitle: const Text("Weather condition: Sunny"),
              trailing: Text(
                locations[index]["temp"]!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}