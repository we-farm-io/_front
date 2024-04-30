import 'package:flutter/material.dart';
import 'package:smart_farm/features/plantdoc/models/plant_info.dart';
import 'package:smart_farm/features/plantdoc/models/plant_species.dart';
import 'package:smart_farm/shared/services/trefle.io_api.dart';

// Define an API service class to handle API requests

// Define a Provider class to manage the state and handle API requests
class PlantProvider extends ChangeNotifier {
  final PlantService _service = PlantService();
  bool isLoading = false;
  final TextEditingController controller = TextEditingController();
  List<PlantSpecies> _species = [];
  List<PlantSpecies> get species => _species;
  PlantInfo plantInfo = PlantInfo();
  Future<void> fetchPlantSpecies(String plantName) async {
    isLoading = true;
    notifyListeners();

    try {
      List<PlantSpecies> response = await _service.fetchPlantSpecies(plantName);
      _species = response;
    } catch (error) {
      // Handle error
      // ignore: avoid_print
      print('Error: $error');
      // Set _plantInfo to an empty PlantInfo object or handle error state as needed
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPlantGrowth(String id) async {
    isLoading = true;

    notifyListeners();
    try {
      // Assign properties of response to _plantInfo
      PlantInfo response = await _service.fetchPlantGrowth(id);
      plantInfo = PlantInfo(
        description: response.description,
        sowing: response.sowing,
        daysToHarvest: response.daysToHarvest,
        rowSpacing: response.rowSpacing,
        spread: response.spread,
        phMaximum: response.phMaximum,
        phMinimum: response.phMinimum,
        light: response.light,
        atmosphericHumidity: response.atmosphericHumidity,
        growthMonths: response.growthMonths,
        bloomMonths: response.bloomMonths,
        fruitMonths: response.fruitMonths,
        minimumPrecipitation: response.minimumPrecipitation,
        maximumPrecipitation: response.maximumPrecipitation,
        minimumRootDepth: response.minimumRootDepth,
        minimumTemperature: Temperature(
            celsius: response.minimumTemperature?.celsius,
            fahrenheit: response.minimumTemperature?.fahrenheit),
        maximumTemperature: Temperature(
            celsius: response.maximumTemperature?.celsius,
            fahrenheit: response.maximumTemperature?.fahrenheit),
        soilNutriments: response.soilNutriments,
        soilSalinity: response.soilSalinity,
        soilTexture: response.soilTexture,
        soilHumidity: response.soilHumidity,
      );
      isLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
