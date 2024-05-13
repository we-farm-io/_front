import 'package:flutter/material.dart';
import 'package:smart_farm/features/plantdoc/models/plant_info.dart';

class PlantInformation extends StatefulWidget {
  // ignore: no_leading_underscores_for_local_identifiers
  const PlantInformation(PlantInfo _plantInfo, {super.key})
      : plantInfo = _plantInfo;
  final PlantInfo plantInfo;

  @override
  State<PlantInformation> createState() => _PlantInformationState();
}

class _PlantInformationState extends State<PlantInformation> {
  @override
  Widget build(BuildContext context) {
    String minTemperatureString =
        '${widget.plantInfo.minimumTemperature?.celsius ?? 'N/A '}°C / ${widget.plantInfo.minimumTemperature?.fahrenheit ?? 'N/A '}°F';
    String maxTemperatureString =
        '${widget.plantInfo.maximumTemperature?.celsius ?? 'N/A '}°C / ${widget.plantInfo.maximumTemperature?.fahrenheit ?? 'N/A '}°F';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildItem('Description', widget.plantInfo.description),
            _buildItem('Sowing', widget.plantInfo.sowing),
            _buildItem('Days to Harvest', widget.plantInfo.daysToHarvest),
            _buildItem('Row Spacing (cm)', widget.plantInfo.rowSpacing),
            _buildItem('Spread (cm)', widget.plantInfo.spread),
            _buildItem('pH Maximum', widget.plantInfo.phMaximum),
            _buildItem('pH Minimum', widget.plantInfo.phMinimum),
            _buildItem('Light', widget.plantInfo.light),
            _buildItem(
                'Atmospheric Humidity', widget.plantInfo.atmosphericHumidity),
            _buildItem('Growth Months', widget.plantInfo.growthMonths),
            _buildItem('Bloom Months', widget.plantInfo.bloomMonths),
            _buildItem('Fruit Months', widget.plantInfo.fruitMonths),
            _buildItem('Minimum Precipitation (mm)',
                widget.plantInfo.minimumPrecipitation),
            _buildItem('Maximum Precipitation (mm)',
                widget.plantInfo.maximumPrecipitation),
            _buildItem(
                'Minimum Root Depth (cm)', widget.plantInfo.minimumRootDepth),
            _buildItem('Minimum Temperature', minTemperatureString),
            _buildItem('Maximum Temperature', maxTemperatureString),
            _buildItem('Soil Nutriments', widget.plantInfo.soilNutriments),
            _buildItem('Soil Salinity', widget.plantInfo.soilSalinity),
            _buildItem('Soil Texture', widget.plantInfo.soilTexture),
            _buildItem('Soil Humidity', widget.plantInfo.soilHumidity),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String title, dynamic value) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(value != null ? value.toString() : 'N/A'),
    );
  }
}
