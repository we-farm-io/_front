import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/features/profile/models/entity.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _usernameController =
      TextEditingController(text: 'mouhamed');
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '0123456789');
  final TextEditingController _passwordController =
      TextEditingController(text: '********');
  final TextEditingController _bioController =
      TextEditingController(text: 'I am just an honest farmer');

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
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
            left: 10,
            child: Transform.scale(
              scaleX: 1.3,
              child: IconButton(
                icon: SvgPicture.asset("assets/icons/arrow-left.svg"),
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
                      return CircleAvatar(
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
                    readOnly: true,
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
                    readOnly: true,
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
                    readOnly: true,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                    readOnly: true,
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
}
