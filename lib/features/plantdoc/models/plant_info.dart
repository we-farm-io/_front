class PlantInfo {
  final String? description;
  final String? sowing;
  final int? daysToHarvest;
  final int? rowSpacing;
  final int? spread;
  final double? phMaximum;
  final double? phMinimum;
  final int? light;
  final int? atmosphericHumidity;
  final List<int>? growthMonths;
  final List<int>? bloomMonths;
  final List<int>? fruitMonths;
  final int? minimumPrecipitation;
  final int? maximumPrecipitation;
  final int? minimumRootDepth;
  final Temperature? minimumTemperature;
  final Temperature? maximumTemperature;
  final int? soilNutriments;
  final int? soilSalinity;
  final String? soilTexture;
  final String? soilHumidity;

  PlantInfo({
    this.description,
    this.sowing,
    this.daysToHarvest,
    this.rowSpacing,
    this.spread,
    this.phMaximum,
    this.phMinimum,
    this.light,
    this.atmosphericHumidity,
    this.growthMonths,
    this.bloomMonths,
    this.fruitMonths,
    this.minimumPrecipitation,
    this.maximumPrecipitation,
    this.minimumRootDepth,
    this.minimumTemperature,
    this.maximumTemperature,
    this.soilNutriments,
    this.soilSalinity,
    this.soilTexture,
    this.soilHumidity,
  });
}

class Temperature {
  final int? celsius;
  final int? fahrenheit;

  Temperature({this.celsius, this.fahrenheit});
}
