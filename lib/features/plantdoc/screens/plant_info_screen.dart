import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_farm/features/plantdoc/models/plant_info.dart';

class PlantInformation extends StatefulWidget {
  const PlantInformation(
    this.plantInfo,
    this.imageurl, {
    Key? key,
  }) : super(key: key);

  final PlantInfo plantInfo;
  final String imageurl;

  @override
  State<PlantInformation> createState() => _PlantInformationState();
}

class _PlantInformationState extends State<PlantInformation> {
  bool _isAnyInformationAvailable() {
    return widget.plantInfo.minimumTemperature!.celsius != null ||
        widget.plantInfo.phMinimum != null ||
        widget.plantInfo.light != null ||
        widget.plantInfo.atmosphericHumidity != null ||
        widget.plantInfo.soilNutriments != null;
    // Add other conditions as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Plant Info",
          style: TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 24),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
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
                        image: CachedNetworkImageProvider(widget.imageurl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _isAnyInformationAvailable()
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 15),
                    child: Column(
                      children: [
                        Gauge(
                          widget.plantInfo.light,
                          "assets/plantcare/sun.svg",
                          "",
                          "Light : ",
                        ),
                        Gauge(
                          widget.plantInfo.atmosphericHumidity,
                          "assets/plantcare/waterdrop.svg",
                          "",
                          "Humidity : ",
                        ),
                        Gauge(
                          widget.plantInfo.soilNutriments,
                          "assets/plantcare/soilnutriments.svg",
                          "",
                          "Nutriments : ",
                        ),
                        if (widget.plantInfo.phMinimum != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "PH : ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "best between ${widget.plantInfo.phMinimum} and ${widget.plantInfo.phMaximum}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (widget.plantInfo.minimumTemperature != null &&
                            widget.plantInfo.minimumTemperature!.celsius !=
                                null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Temperature:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "${widget.plantInfo.minimumTemperature!.celsius} °C to ${widget.plantInfo.maximumTemperature!.celsius}°C",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "No information available yet",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      fontSize: 18,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class Gauge extends StatelessWidget {
  const Gauge(
    this._light,
    this._svgPictureLeading,
    this._svgPictureTrailing,
    this._title, {
    Key? key,
  }) : super(key: key);

  final int? _light;
  final String _svgPictureLeading;
  final String _svgPictureTrailing;
  final String _title;

  @override
  Widget build(BuildContext context) {
    if (_light != null) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added
          children: [
            Text(
              _title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                fontSize: 18,
              ),
            ),
            Expanded(
              // Added
              child: Container(
                alignment: Alignment.centerRight, // Added
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Added
                  children: [
                    if (_svgPictureLeading.isNotEmpty)
                      SvgPicture.asset(
                        _svgPictureLeading,
                        height: 20,
                        width: 20,
                      ),
                    const SizedBox(width: 15),
                    for (int i = 0; i < 10; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            color: i == _light
                                ? Colors.green
                                : const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.horizontal(
                              left: i == 0
                                  ? const Radius.circular(18)
                                  : Radius.zero,
                              right: i == 10 - 1
                                  ? const Radius.circular(18)
                                  : Radius.zero,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 15),
                    if (_svgPictureTrailing.isNotEmpty)
                      SvgPicture.asset(
                        _svgPictureTrailing,
                        height: 20,
                        width: 20,
                      ),
                    if (_svgPictureTrailing.isEmpty)
                      SizedBox(
                        width: 20,
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
