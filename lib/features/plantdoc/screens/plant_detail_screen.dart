import 'package:flutter/material.dart';
import 'package:smart_farm/features/plantdoc/models/plant_data.dart';

class PlantDetailScreen extends StatelessWidget {
  final PlantData plantData;

  const PlantDetailScreen({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Details'),
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
          const SizedBox(height: 20),
          Text(
            'Disease: ${plantData.disease}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Definition: ${plantData.definition}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Solution: ${plantData.solution}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
