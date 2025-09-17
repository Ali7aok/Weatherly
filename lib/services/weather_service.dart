import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherly/services/location_service.dart';
class WeatherService {
  final String apiKey = "----------------------YOUR_API_KEY_HERE------------------";

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load weather");
    }
  }

  Future<Map<String, dynamic>> getWeatherByCoords(double lat, double lon) async {
  final url = Uri.parse(
    "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric",
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to load weather");
  }
}


LocationService locationS = LocationService();
Future<Map<String, dynamic>> getWeatherFromDeviceLocation() async {
  final position = await locationS.getCurrentLocation(); // ينتظر حتى يجيب الموقع
  final lat = position.latitude;
  final lon = position.longitude;

  final url = Uri.parse(
    "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric",
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to load weather");
  }
}


}
