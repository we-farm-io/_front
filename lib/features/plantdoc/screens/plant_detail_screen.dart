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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.file(
                plantData.image,
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                'Disease: ${plantData.disease}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Definition: ${plantData.definition}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Solution: ${plantData.solution}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
