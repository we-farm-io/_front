import 'dart:io';

class PlantData {
  final File image;
  final String disease;
  final String definition;
  final String solution;

  PlantData({
    required this.image,
    required this.disease,
    required this.definition,
    required this.solution,
  });
}
