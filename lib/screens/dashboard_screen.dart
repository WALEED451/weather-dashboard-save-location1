import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Weather Dashboard"),
        backgroundColor: const Color(0xFF0B1D4A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Faisalabad, Pakistan",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.wb_sunny,
              size: 90,
              color: Colors.orange,
            ),
            const Text(
              "28°C",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Sunny",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                weatherInfo(Icons.water_drop, "Humidity", "45%"),
                weatherInfo(Icons.air, "Wind", "12 km/h"),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Today's Forecast",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text("9 AM      22°C     ☀️"),
            const Text("12 PM    28°C     ☀️"),
            const Text("3 PM      30°C     🌤️"),
            const Text("6 PM      25°C     🌙"),
          ],
        ),
      ),
    );
  }

  Widget weatherInfo(IconData icon, String title, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Icon(icon, size: 30),
              Text(title),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}