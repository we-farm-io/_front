import 'package:flutter/material.dart';
import 'package:smart_farm/features/plantdoc/models/plant_data.dart';

class PlantDetailScreen extends StatelessWidget {
  final PlantData plantData;

  const PlantDetailScreen({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Plant Details',
          style: TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(plantData.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
          Text(
            'Disease: ${plantData.disease}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins"),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Definition: ${plantData.definition}',
            style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Solution: ${plantData.solution}',
            style: const TextStyle(fontSize: 16, fontFamily: "Poppins"),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
