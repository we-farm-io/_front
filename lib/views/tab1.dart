import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/views/plant_detail_screen.dart';

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

class Tab1 extends StatefulWidget {
  const Tab1({super.key});

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  List<PlantData> _recentPlantData = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadRecentPlantData();
  }

  Future<void> _saveRecentPlantData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recentPlantDataStrings = _recentPlantData.map((plantData) {
      return '${plantData.image.path},${plantData.disease},${plantData.definition},${plantData.solution}';
    }).toList();
    await prefs.setStringList('recentPlantData', recentPlantDataStrings);
  }

  Future<void> _loadRecentPlantData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentPlantDataStrings =
        prefs.getStringList('recentPlantData');
    if (recentPlantDataStrings != null) {
      setState(() {
        _recentPlantData = recentPlantDataStrings.map((dataString) {
          List<String> parts = dataString.split(',');
          return PlantData(
            image: File(parts[0]),
            disease: parts[1],
            definition: parts[2],
            solution: parts[3],
          );
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _recentPlantData.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.file(
              _recentPlantData[index].image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text('Disease: ${_recentPlantData[index].disease}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantDetailScreen(
                    plantData: _recentPlantData[index],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22),
        backgroundColor: Colors.lightGreen,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          // FAB 1
          SpeedDialChild(
              child: const Icon(Icons.photo_album),
              backgroundColor: Colors.lightGreen,
              onTap: () {
                _pickImageFromGallery();
              },
              label: 'Gallery',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Colors.lightGreen),
          // FAB 2
          SpeedDialChild(
              child: const Icon(Icons.camera),
              backgroundColor: Colors.lightGreen,
              onTap: () {
                _pickImageFromCamera();
              },
              label: 'Camera',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0),
              labelBackgroundColor: Colors.lightGreen)
        ],
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Todo: You can prompt user to input disease, definition, and solution here.
      PlantData newPlantData = PlantData(
        image: File(pickedFile.path),
        disease: 'Some Disease',
        definition: 'Some Definition',
        solution: 'Some Solution',
      );
      setState(() {
        _recentPlantData.add(newPlantData);
        _saveRecentPlantData();
        // Todo: Implement the result screen
      });
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlantDetailScreen(
            plantData: newPlantData,
          ),
        ),
      );
    }
  }

  Future _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Todo: You can prompt user to input disease, definition, and solution here.
      PlantData newPlantData = PlantData(
        image: File(pickedFile.path),
        disease: 'Some Disease',
        definition: 'Some Definition',
        solution: 'Some Solution',
      );
      setState(() {
        _recentPlantData.add(newPlantData);
        _saveRecentPlantData();
        // Todo: Implement the result screen
      });
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlantDetailScreen(
            plantData: newPlantData,
          ),
        ),
      );
    }
  }
}
