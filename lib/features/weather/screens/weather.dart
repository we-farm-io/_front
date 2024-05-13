// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/weather/providers/weather_provider.dart';
import 'package:smart_farm/features/weather/widgets/weather_view.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    _determinePosition(context);
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    final weather = 
        Provider.of<WeatherProvider>(context, listen: false);
    final position = await _determinePosition(context);
    weather.fetchWeather(position);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Image.asset('assets/images/weather/wallpaper.png'),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: FutureBuilder(
                  future: _determinePosition(context),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return Consumer<WeatherProvider>(
                        builder: (context, weather, child) {
                          if (weather.weather == null) {
                            return _buildLoadingIndicator();
                          } else {
                            return weatherView(weather);
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

}


Future<Position> _determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Services Disabled"),
          content: const Text("Please enable location services."),
          actions: [
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text("Got it", style: TextStyle(color: Palette.buttonGreen),),
            ),
          ],
        );
      },
    );
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Location Permissions Denied"),
            content: const Text("Please grant location permissions."),
            actions: [
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
              child: const Text("Got it", style: TextStyle(color: Palette.buttonGreen),),
              ),
            ],
          );
        },
      );
    }
  }

  if (permission == LocationPermission.deniedForever) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Permissions Denied"),
          content: const Text("Location permissions are permanently denied, we cannot request permissions."),
          actions: [
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text("Got it", style: TextStyle(color: Palette.buttonGreen),),
            ),
          ],
        );
      },
    );
  }

  return await Geolocator.getCurrentPosition();
}
