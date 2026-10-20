
import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int selectedIndex = 0;
  bool isDark = false;
  bool useFahrenheit = false;

  final List<String> cities = [
    'Lahore',
    'Karachi',
    'Islamabad',
  ];

  final Map<String, int> temperatures = {
    'Lahore': 30,
    'Karachi': 32,
    'Islamabad': 28,
    'Multan': 35,
    'Sahiwal': 31,
    'Peshawar': 27,
  };

  String currentCity = 'Islamabad';

  void selectCity(String city) {
    setState(() {
      currentCity = city;
      selectedIndex = 0;
    });
  }

  void addCity(String city) {
    setState(() {
      if (!cities.contains(city)) {
        cities.add(city);
      }
      currentCity = city;
      selectedIndex = 0;
    });
  }

  int getTemperature(String city) {
    int celsius = temperatures[city] ?? 28;
    return useFahrenheit ? (celsius * 9 / 5 + 32).round() : celsius;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
        isDark ? const Color(0xFF101827) : const Color(0xFFF2F7FF),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [
            dashboard(),
            savedLocations(),
            searchCity(),
            settings(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboard() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wb_sunny,
                size: 90, color: Colors.orange),
            const SizedBox(height: 20),
            Text(
              currentCity,
              style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              '${getTemperature(currentCity)}°'
                  '${useFahrenheit ? 'F' : 'C'}',
              style: const TextStyle(
                  fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const Text('Sunny / Partly Cloudy',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 25),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      Icon(Icons.water_drop, color: Colors.blue),
                      Text('Humidity'),
                      Text('60%'),
                    ]),
                    Column(children: [
                      Icon(Icons.air, color: Colors.blue),
                      Text('Wind'),
                      Text('12 km/h'),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget savedLocations() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'My Saved Locations',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...cities.map((city) => Card(
          child: ListTile(
            leading: const Icon(Icons.location_on,
                color: Colors.blue),
            title: Text(city),
            subtitle: Text(
              '${getTemperature(city)}°'
                  '${useFahrenheit ? 'F' : 'C'} • Sunny',
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => selectCity(city),
          ),
        )),
      ],
    );
  }

  Widget searchCity() {
    final controller = TextEditingController();

    return StatefulBuilder(
      builder: (context, setSearchState) {
        String query = '';

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Search City',
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setSearchState(() {
                    query = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: temperatures.keys
                      .where((city) => city
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                      .map((city) => Card(
                    child: ListTile(
                      leading: const Icon(
                          Icons.location_city,
                          color: Colors.blue),
                      title: Text(city),
                      subtitle: Text(
                        '${getTemperature(city)}°'
                            '${useFahrenheit ? 'F' : 'C'}',
                      ),
                      trailing:
                      const Icon(Icons.add_circle),
                      onTap: () => addCity(city),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget settings() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        SwitchListTile(
          title: const Text('Fahrenheit temperature'),
          subtitle: const Text('Off = Celsius, On = Fahrenheit'),
          value: useFahrenheit,
          onChanged: (value) {
            setState(() {
              useFahrenheit = value;
            });
          },
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Change app appearance'),
          value: isDark,
          onChanged: (value) {
            setState(() {
              isDark = value;
            });
          },
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About App'),
          subtitle: Text('Weather Dashboard v1.0'),
        ),
      ],
    );
  }
}
