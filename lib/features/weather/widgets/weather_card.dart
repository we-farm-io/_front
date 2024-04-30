import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WeatherCard extends StatelessWidget {
  String value;
  Widget image;
  String label;
   WeatherCard({
    super.key,
    required this.image,
    required this.label,
    required this. value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width:MediaQuery.of(context).size.width*0.4,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(52, 199, 89, 1),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.height*0.2,
            child: image),
           Text(value , style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'poppins',
        fontSize: 24,
        color: Colors.white),),
        const SizedBox(height: 8,),
           Text(label, style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'poppins',
        fontSize: 16,
        color: Colors.white),),
        const SizedBox(height: 16,)
        ],
      ),
    );
  }
}
