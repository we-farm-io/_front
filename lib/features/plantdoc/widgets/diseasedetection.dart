import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/features/plantdoc/models/plant_data.dart';
import 'package:smart_farm/features/plantdoc/screens/plant_detail_screen.dart';

class Tab1 extends StatefulWidget {
  const Tab1({super.key});

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  List<PlantData> _recentPlantData = [];
  final picker = ImagePicker();
  bool _loading = true;
  late File _image;
  late List _output;

  @override
  void initState() {
    super.initState();
    _loadRecentPlantData();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.file(
                _recentPlantData[_recentPlantData.length - index - 1].image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              title: Text(_recentPlantData[_recentPlantData.length - index - 1]
                  .disease),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantDetailScreen(
                      plantData:
                          _recentPlantData[_recentPlantData.length - index - 1],
                    ),
                  ),
                );
              },
            ),
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
      int index = await classifyImage(pickedFile);

      PlantData newPlantData = await searchDiseaseByCode(index, pickedFile);
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

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/models/model.tflite',
        labels: 'assets/models/labels.txt');
  }

  classifyImage(XFile pickedFile) async {
    var outputs = await Tflite.runModelOnImage(
      path: pickedFile.path,
      numResults: 1,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
    });
    if (outputs != null && outputs.isNotEmpty) {
      print(outputs);
      return outputs[0]['index'];
    }
  }

  Future<Map<String, dynamic>> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/models/diseases.json');
    return jsonDecode(jsonString);
  }

  searchDiseaseByCode(int code, XFile pickedfile) async {
    Map<String, dynamic> jsonData = await loadJsonData();
    List<dynamic> diseases = jsonData['diseases'];

    for (var disease in diseases) {
      if (disease['code'] == code) {
        return PlantData(
          image: File(pickedfile.path),
          disease: disease['disease'],
          definition: disease['definition'],
          solution: disease['solution'],
        );
      }

      print('Disease not found.');
    }
  }
}
