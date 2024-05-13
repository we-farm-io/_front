import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WeatherText extends StatelessWidget {
  String text;
   WeatherText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width*0.8,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(52, 199, 89, 1),
          borderRadius: BorderRadius.circular(30)),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'poppins',
            fontSize: 14,
            color: Colors.white),
      ),
    );
  }
}