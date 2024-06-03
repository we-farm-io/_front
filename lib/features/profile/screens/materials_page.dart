import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/features/profile/models/entity.dart';
import 'package:smart_farm/features/profile/widgets/customentry.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

User? currentUser = FirebaseAuth.instance.currentUser;
List<Entity> materials = [];

class _MaterialsPageState extends State<MaterialsPage> {
  Future<void> addCropToUserProfile(String materialType, int quantity) async {
    if (currentUser != null) {
      String userId = currentUser!.uid;

      DocumentReference materialDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('materials')
          .doc(materialType);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(materialDoc);

        if (!snapshot.exists) {
          transaction.set(materialDoc, {'totalQuantity': quantity});
        } else {
          int newTotalQuantity =
              (snapshot.data() as Map<String, dynamic>)['totalQuantity'] +
                  quantity;
          transaction.update(materialDoc, {'totalQuantity': newTotalQuantity});
        }
      });
      DocumentReference globaldoc =
          FirebaseFirestore.instance.collection('materials').doc(materialType);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(globaldoc);

        if (!snapshot.exists) {
          transaction.set(globaldoc, {'totalQuantity': quantity});
        } else {
          int newTotalQuantity =
              (snapshot.data() as Map<String, dynamic>)['totalQuantity'] +
                  quantity;
          transaction.update(globaldoc, {'totalQuantity': newTotalQuantity});
        }
      });

      print('Crop added successfully!');
      if (mounted) {
        setState(() {});
        _showSnackbar(context);
      }
    } else {
      throw Exception('No userqsd is currently signed in.');
    }
  }

  Future getUserCrops() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('materials')
          .get();

      materials = snapshot.docs.map((doc) {
        return Entity(
            doc.id, (doc.data() as Map<String, dynamic>)['totalQuantity']);
      }).toList();
      print("list getted");
    } else {
      throw Exception('No user is currently signed in.');
    }
  }

  void _addCrop(BuildContext context) {
    String name = '';
    int quantity = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Material'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: const InputDecoration(labelText: 'Material Name'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantity = int.parse(value);
                },
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                addCropToUserProfile(name, quantity);

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Added Successfully!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: IconButton(
        icon: SvgPicture.asset('assets/icons/Profile/message-add.svg'),
        onPressed: () {
          _addCrop(context);
        },
      ),
      body: FutureBuilder(
          future: getUserCrops(),
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
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
                            icon:
                                SvgPicture.asset("assets/icons/arrow-left.svg"),
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
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 69,
                              child: Image.asset(
                                  'assets/icons/Profile/materials_profile.png'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Materials",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            Container(
                              padding: const EdgeInsets.all(0),
                              height: 65 * mediaQuery.size.height / 100,
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: materials.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 10),
                                      child: Column(
                                        children: [
                                          CustomEntry(
                                            hintText: materials[index]
                                                .value
                                                .toString(),
                                            cropsName: materials[index].name,
                                          ),
                                        ],
                                        
                                      ),
                                    );
                                  }),
                            ),
                            // Add other widgets as needed
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
