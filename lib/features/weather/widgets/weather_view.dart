import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/features/weather/providers/weather_provider.dart';
import 'package:smart_farm/features/weather/widgets/weather_card.dart';
import 'package:smart_farm/features/weather/widgets/weather_text.dart';

Widget weatherView(WeatherProvider weatherProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Today's Weather",
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Today's Date",
          style: TextStyle(
            fontFamily: 'poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: WeatherText(
            text: DateFormat.yMMMEd().format(DateTime.now()),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "My location",
          style: TextStyle(
            fontFamily: 'poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: WeatherText(
            text: weatherProvider.weather?.areaName ?? '',
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WeatherCard(
              image: Image.asset('assets/images/weather/sun.png'),
              label: 'Temperature',
              value:
                  '${weatherProvider.weather?.temperature!.celsius!.round()}°C',
            ),
            WeatherCard(
              image: Image.asset('assets/images/weather/sun-clouds-rain.png'),
              label: 'Humidity',
              value: '${weatherProvider.weather?.humidity}%',
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WeatherCard(
              image: Image.asset('assets/images/weather/bolt.png'),
              label: 'Wind Speed',
              value: '${weatherProvider.weather?.windSpeed}Km/h',
            ),
            WeatherCard(
              image: Image.asset('assets/images/weather/clouds-rain.png'),
              label: 'RainFall',
              value: '${weatherProvider.weather?.rainLast3Hours ?? '0'} mm',
            ),
          ],
        ),
      ],
    );
  }