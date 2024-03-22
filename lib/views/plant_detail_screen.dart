import 'package:flutter/material.dart';
import 'package:smart_farm/views/tab1.dart';

class PlantDetailScreen extends StatelessWidget {
  final PlantData plantData;

  const PlantDetailScreen({Key? key, required this.plantData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.file(
            plantData.image,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            'Disease: ${plantData.disease}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Definition: ${plantData.definition}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Solution: ${plantData.solution}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
