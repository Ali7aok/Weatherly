import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/services/weather_service.dart';


class WeatherGrid extends StatefulWidget {
  const WeatherGrid({super.key});

  @override
  State<WeatherGrid> createState() => _WeatherGridState();
}

class _WeatherGridState extends State<WeatherGrid> {
  Map<String, dynamic>? weather;
  bool loading = true;

  final WeatherService service = WeatherService();

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    try {
      // مثال: تستخدم إحداثيات بغداد
      final data = await service.getWeatherByCoords(33.3, 44.4);
      setState(() {
        weather = data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      print("Error: $e");
    }
  }

  Widget _buildTile(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blueGrey[700]),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.transparent,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : GridView(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              children: [
                _buildTile(Icons.location_on_outlined, weather?['name'] ?? '--'), // المدينة
                _buildTile(Icons.thermostat_outlined,
                    "${weather?['main']?['temp']?.toStringAsFixed(1) ?? '--'} °C"), // الحرارة
                _buildTile(Icons.water_drop_outlined,
                    "${weather?['main']?['humidity']?.toString() ?? '--'} %"), // الرطوبة
                _buildTile(Icons.air_outlined,
                    "${weather?['wind']?['speed']?.toString() ?? '--'} m/s"), // الرياح
                _buildTile(Icons.visibility_outlined,
                    "${((weather?['visibility'] ?? 0) / 1000).toStringAsFixed(1)} km"), // الرؤية
                _buildTile(Icons.wb_sunny_outlined,
                    "${weather?['weather']?[0]?['main'] ?? '--'}"), // حالة الطقس
                _buildTile(Icons.access_time,
                    DateFormat('h a').format(DateTime.now())), // الساعة الحالية
              ],
            ),
    );
  }
}
