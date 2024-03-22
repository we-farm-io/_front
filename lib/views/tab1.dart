import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tab1 extends StatefulWidget {
  const Tab1({super.key});

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  File? _selectedImage;
  List<File> _recentPhotos = [];
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _loadRecentPhotos();
  }

  Future<void> _saveRecentPhotos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>
        recentPhotoPaths = //todo make the list contain image plus result
        _recentPhotos.map((photo) => photo.path).toList();
    await prefs.setStringList('recentPhotos', recentPhotoPaths);
  }

  Future<void> _loadRecentPhotos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentPhotoPaths = prefs.getStringList('recentPhotos');
    if (recentPhotoPaths != null) {
      setState(() {
        _recentPhotos = recentPhotoPaths.map((path) => File(path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _recentPhotos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.file(
              _recentPhotos[index],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            onTap: () {
              //todo implement what happens when history element chosen (show result screen from history)
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
    final returnedImage = await picker.pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
      _recentPhotos.add(_selectedImage!);
      _saveRecentPhotos();
      //todo implement the result screen
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage = await picker.pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
      _recentPhotos.add(_selectedImage!);
      _saveRecentPhotos();
      //todo implement the result screen
    });
  }
}
