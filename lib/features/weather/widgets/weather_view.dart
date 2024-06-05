import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/features/weather/providers/weather_provider.dart';
import 'package:smart_farm/features/weather/widgets/weather_card.dart';
import 'package:smart_farm/features/weather/widgets/weather_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget weatherView(WeatherProvider weatherProvider, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.todaysWeather,
            style: const TextStyle(
              fontFamily: 'poppins',
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context)!.todaysDate,
          style: const TextStyle(
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
         Text(
          AppLocalizations.of(context)!.myLocation,
          style: const TextStyle(
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
              label: AppLocalizations.of(context)!.temperature,
              value:
                  '${weatherProvider.weather?.temperature!.celsius!.round()}°C',
            ),
            WeatherCard(
              image: Image.asset('assets/images/weather/sun-clouds-rain.png'),
              label: AppLocalizations.of(context)!.humidity,
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
              label: AppLocalizations.of(context)!.windSpeed,
              value: '${weatherProvider.weather?.windSpeed}Km/h',
            ),
            WeatherCard(
              image: Image.asset('assets/images/weather/clouds-rain.png'),
              label: AppLocalizations.of(context)!.rainFall,
              value: '${weatherProvider.weather?.rainLast3Hours ?? '0'} mm',
            ),
          ],
        ),
      ],
    );
  }