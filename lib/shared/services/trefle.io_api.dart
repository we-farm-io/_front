import 'dart:convert';
import 'package:http/http.dart';
import 'package:smart_farm/features/plantdoc/models/plant_info.dart';
import 'package:smart_farm/features/plantdoc/models/plant_species.dart';

class PlantService {
  final String token = "O8S6iANTxL28sxv7L6vBpTwTDogYH6IhX6p05hrCgEc";
  //this is our token for trefle.io api
  Future<List<PlantSpecies>> fetchPlantSpecies(String plantname) async {
    // Step 4: Fetch Data

    final response = await get(
      Uri(
        scheme: 'https',
        host: 'trefle.io',
        path: '/api/v1/plants/search',
        queryParameters: {'token': token, 'q': plantname},
      ),
    );
    if (response.statusCode == 200) {
      final jsonplant = json.decode(response.body);
      final species = (jsonplant['data'] as List)
          .map(
            (specie) => PlantSpecies(
                commonName: specie['common_name'],
                scientificName: specie['scientific_name'],
                photoUrl: specie['image_url'],
                id: specie['id'].toString()),
          )
          .toList();

      return species; // Step 5: Update State
    } else {
      throw Exception('Failed to load species');
    }
  }

  Future<PlantInfo> fetchPlantGrowth(String id) async {
    // ignore: avoid_print
    print('we are here ');
    final response = await get(Uri(
      scheme: 'https',
      host: 'trefle.io',
      path: "/api/v1/species/$id",
      queryParameters: {'token': token},
    ));
    if (response.statusCode == 200) {
      final jsonplant = json.decode(response.body);
      final species = jsonplant['data'];
      final speciesGrowth = species['growth'];
      PlantInfo speciesinfo = PlantInfo(
        description: speciesGrowth['description'],
        sowing: speciesGrowth['sowing'],
        daysToHarvest: speciesGrowth['days_to_harvest'],
        rowSpacing: speciesGrowth['row_spacing'] != null
            ? speciesGrowth['row_spacing']['cm']
            : null,
        spread: speciesGrowth['spread'] != null
            ? speciesGrowth['spread']['cm']
            : null,
        phMaximum: speciesGrowth['ph_maximum'],
        phMinimum: speciesGrowth['ph_minimum'],
        light: speciesGrowth['light'],
        atmosphericHumidity: speciesGrowth['atmospheric_humidity'],
        growthMonths: speciesGrowth['growth_months'],
        bloomMonths: speciesGrowth['bloom_months'],
        fruitMonths: speciesGrowth['fruit_months'],
        minimumPrecipitation: speciesGrowth['minimum_precipitation'] != null
            ? speciesGrowth['minimum_precipitation']['mm']
            : null,
        maximumPrecipitation: speciesGrowth['maximum_precipitation'] != null
            ? speciesGrowth['maximum_precipitation']['mm']
            : null,
        minimumRootDepth: speciesGrowth['minimum_root_depth'] != null
            ? speciesGrowth['minimum_root_depth']['cm']
            : null,
        minimumTemperature: speciesGrowth['minimum_temperature'] != null
            ? Temperature(
                celsius: speciesGrowth['minimum_temperature']['deg_c'],
                fahrenheit: speciesGrowth['minimum_temperature']['deg_f'])
            : null,
        maximumTemperature: speciesGrowth['maximum_temperature'] != null
            ? Temperature(
                celsius: speciesGrowth['maximum_temperature']['deg_c'],
                fahrenheit: speciesGrowth['maximum_temperature']['deg_f'])
            : null,
        soilNutriments: speciesGrowth['soil_nutriments'],
        soilSalinity: speciesGrowth['soil_salinity'],
        soilTexture: speciesGrowth['soil_texture'],
        soilHumidity: speciesGrowth['soil_humidity'],
      );

      return speciesinfo;
    } else {
      throw Exception('failed to load plant data');
    }
  }
}
