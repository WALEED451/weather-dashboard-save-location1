import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;
  String unit = "Celsius";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings & Reporting"),
        backgroundColor: const Color(0xFF0B1D4A),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "App Settings",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SwitchListTile(
            title: const Text("Notifications"),
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),
          const SizedBox(height: 10),
          const Text("Temperature Unit"),
          DropdownButton<String>(
            value: unit,
            isExpanded: true,
            items: ["Celsius", "Fahrenheit"]
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  unit = value;
                });
              }
            },
          ),
          const Divider(height: 35),
          const Text(
            "Report Weather",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: "City name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Describe weather conditions",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Weather report submitted!"),
                ),
              );
            },
            child: const Text("Submit Report"),
          ),
        ],
      ),
    );
  }
}