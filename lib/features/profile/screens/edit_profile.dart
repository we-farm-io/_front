import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import for Firebase Authentication
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isnotEditing = true;
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          setState(() {
            _usernameController.text = userDoc['name'] ?? '';
            _phoneNumberController.text = userDoc['phonenumber'] ?? '';
            _bioController.text = userDoc['bio'] ?? '';
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load user data')),
        );
      }
    } else {
      print('No user is currently signed in.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user is currently signed in')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: const Color(0xFF0D986A),
              height: mediaQuery.size.height / 4,
            ),
          ),
          Positioned(
            top: 50,
            left: locale.localeName == "en" ? 10 : null,
            right: locale.localeName == "en" ? null : 10,
            child: Transform.scale(
              scaleX: 1.3,
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/arrow-left.svg",
                  matchTextDirection: true,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: mediaQuery.size.height / 10,
            right: 0,
            left: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: getImage,
                  child: Builder(builder: (context) {
                    if (_image != null) {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 69,
                        child: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(
                            _image!,
                          ),
                          radius: 64,
                        ),
                      );
                    } else {
                      return const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 69,
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage('assets/images/palestine.png'),
                        ),
                      );
                    }
                  }),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    readOnly: _isnotEditing,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    readOnly: _isnotEditing,
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    readOnly: _isnotEditing,
                    controller: _bioController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.lightGreen)),
                          onPressed: () {
                            setState(() {
                              _isnotEditing = true;
                            });
                            _saveUserInfo(); // Call the save function
                          },
                          child: const Text(
                            "save",
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.lightGreen)),
                          onPressed: () {
                            setState(() {
                              _isnotEditing = false;
                            });
                          },
                          child: const Text(
                            "edit",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: mediaQuery.size.height / 14,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.topCenter,
              child: const Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveUserInfo() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid; // Get the user ID

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'name': _usernameController.text.trim(),
          'phonenumber': _phoneNumberController.text.trim(),
          'bio': _bioController.text.trim(),
          // Add other fields as necessary
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    } else {
      print('No user is currently signed in.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user is currently signed in')),
      );
    }
  }
}
