import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherly/services/location_service.dart';
import 'package:weatherly/services/weather_service.dart';
import 'package:weatherly/widgets/custom_bottom_drawer.dart';
import 'package:weatherly/widgets/custom_dialog.dart';
import 'package:weatherly/widgets/weather_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Widget _buildTile(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.all(0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.24),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 0),
          Text(text, style: const TextStyle(color: Colors.black)),
        ],
      ),
    ),
  );
}

class _HomePageState extends State<HomePage> {
  final WeatherService service = WeatherService();
  Map<String, dynamic>? weather;
  bool loading = true;
  String error = '';
  @override
  void initState() {
    super.initState();
    loadWeather();
  }


Future<void> loadWeather() async {
  try {
    final data = await WeatherService().getWeatherFromDeviceLocation();
    setState(() {
      weather = data;
      loading = false;
    });
  } catch (e) {
    print("Error: $e");
    error = e.toString();
    setState(() => loading = false);
  }
}


  /* Future<void> loadWeather() async {
    try {
      final position = await LocationService().getCurrentLocation();
      print("📍 Location: ${position.latitude}, ${position.longitude}");

      final data = await service.getWeatherByCoords(
        position.latitude,
        position.longitude,
      );
      print("🌦️ Weather data: $data");

      setState(() {
        weather = data;
        loading = false;
      });
    } catch (e) {
      print("❌ Error: $e");
      error = e.toString();
      setState(() {
        loading = false;
        weather = null;
      });
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 👈 pushes top & bottom apart
          //  crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 24),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row: Title + Close Icon
                          Icon(Icons.cloud_outlined, size: 100),
                          // Content
                          Text(
                            "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),

                      Expanded(
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: 1.5,
                              ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildTile(
                              Icons.thermostat_outlined,
                              "${weather?['main']?['temp']?.toStringAsFixed(1) ?? '--'}°C",
                            ),
                            _buildTile(
                              Icons.water_drop_outlined,
                              "${weather?['main']?['humidity']?.toString() ?? '--'}%",
                            ),
                            _buildTile(
                              Icons.air_outlined,
                              "${weather?['wind']?['speed']?.toString()} m/s",
                            ),
                            _buildTile(
                              Icons.visibility_outlined,
                              "${((weather?['visibility'] ?? 0) / 1000).toStringAsFixed(1)} km",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child:   loading
                        ? Center(child: const CircularProgressIndicator())
                        : weather == null
                        ?  Text(error)
                        : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     
                         
      const Text(
         "It's",
        style: TextStyle(fontSize: 80, color: Colors.black , fontWeight: FontWeight.bold, height: 0.9,),
      ),
      Text(
         "${weather?['weather'][0]?['main'] ?? 'Unknown'}",
        style: const TextStyle(
          fontFamily: 'MyWeatherFont',
          fontSize: 80,
          color: Colors.black,
          height: 0.9,
        ),
      ),
    Text(
       "now.",
        style: TextStyle(fontSize: 80, color: Colors.black,fontWeight: FontWeight.bold, height: 0.9,),
      ),
  
    

                    SizedBox(height: 20),
                    InkWell(
                      highlightColor: Colors.lightBlueAccent.withOpacity(0.3),
                      onTap: () {
                        // Handle tap event
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true, // حتى ياخذ حجم المحتوى
                          builder: (context) {
                            return CustomBottomDrawer(
                              title: "More Information:",
                              children: [
                           Container(
                            height: 250,
                            child: WeatherGrid()),
                              ],
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Text(
                        "You can click here to see more infromation",
                        style: TextStyle(
                          color: Colors.grey[710],
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

              
                  ],
                ),
              ),
            ),

            Column(
              children: [
                Divider(color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Location
                    Column(
                      children: [
                        Icon(Icons.location_on, size: 44),
                        Text(weather?['name'] ?? 'Unknown', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    Container(height: 44, width: 1, color: Colors.black),
                    //Temperature
                    Text(
                     "${weather?['main']?['temp']?.toStringAsFixed(1) ?? '--'}°C",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(height: 44, width: 1, color: Colors.black),
                    //Clock
                    Text(
                        DateFormat('ha').format(DateTime.now()), 
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
        child: const Icon(Icons.refresh, color: Colors.white),
        onPressed: () {
          setState(() {
            loading = true;
          //  error = '';
          });
          loadWeather();
          WeatherGrid();
        },)
    );
  }
}
