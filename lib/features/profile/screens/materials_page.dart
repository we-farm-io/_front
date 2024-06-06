import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/features/profile/models/entity.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      print('material added successfully!');
      if (mounted) {
        setState(() {});
        _showSnackbar(context, "Added Successfully");
      }
    } else {
      throw Exception('No userqsd is currently signed in.');
    }
  }

  Future<void> updateCropInUserProfile(
      String oldCropType, String newCropType, int quantity) async {
    if (currentUser != null) {
      String userId = currentUser!.uid;

      DocumentReference oldCropDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('materials')
          .doc(oldCropType);

      DocumentReference newCropDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('materials')
          .doc(newCropType);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot oldSnapshot = await transaction.get(oldCropDoc);

        if (oldSnapshot.exists) {
          if (oldCropType != newCropType) {
            // Rename crop
            transaction.delete(oldCropDoc);
            transaction.set(newCropDoc, {'totalQuantity': quantity});
          } else {
            // Update quantity
            transaction.update(oldCropDoc, {'totalQuantity': quantity});
          }
        }
      });
      print('material updated successfully!');
      setState(() {});
      _showSnackbar(context, 'Updated Successfully!');
    } else {
      throw Exception('No user is currently signed in.');
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

  void _addOrEditCrop(BuildContext context, String defaultname,
      int defaultquantity, String action, String buttonaction, bool isEdit) {
    String name = defaultname;
    int quantity = defaultquantity;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${action} Material'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: name),
                onChanged: (value) {
                  name = value;
                },
                decoration: const InputDecoration(labelText: 'Material Name'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: quantity.toString()),
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
                if (isEdit) {
                  updateCropInUserProfile(defaultname, name, quantity);
                } else {
                  addCropToUserProfile(name, quantity);
                }
                Navigator.of(context).pop();
              },
              child: Text(buttonaction),
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

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
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
    AppLocalizations locale = AppLocalizations.of(context)!;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: IconButton(
        icon: SvgPicture.asset('assets/icons/Profile/message-add.svg'),
        onPressed: () {
          _addOrEditCrop(context, '', 0, "Add", "Add", false);
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
                                          Slidable(
                                            key:
                                                ValueKey(materials[index].name),
                                            startActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    _addOrEditCrop(
                                                        context,
                                                        materials[index].name,
                                                        materials[index].value,
                                                        "Edit",
                                                        "Save",
                                                        true);
                                                  },
                                                  icon: Icons.edit,
                                                ),
                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    _showDeleteConfirmationDialog(
                                                        context,
                                                        materials[index].name);
                                                  },
                                                  icon: Icons.delete,
                                                  backgroundColor: Colors.red,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 30.0),
                                                    child: Text(
                                                      materials[index].name,
                                                      style: const TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                TextField(
                                                  readOnly: true,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: false),
                                                  controller:
                                                      TextEditingController(),
                                                  style: const TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20),
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    hintText: materials[index]
                                                        .value
                                                        .toString(),
                                                    hintStyle: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 40,
                                                            vertical: 10),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Palette
                                                                  .buttonGreen),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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

  void _showDeleteConfirmationDialog(BuildContext context, String cropType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this crop?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteCropFromUserProfile(cropType);
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteCropFromUserProfile(String cropType) async {
    if (currentUser != null) {
      String userId = currentUser!.uid;

      DocumentReference cropDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('crops')
          .doc(cropType);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(cropDoc);

        if (snapshot.exists) {
          int totalQuantity =
              (snapshot.data() as Map<String, dynamic>)['totalQuantity'];

          if (totalQuantity > 1) {
            transaction.update(cropDoc, {'totalQuantity': totalQuantity - 1});
          } else {
            transaction.delete(cropDoc);
          }
        }
      });
      DocumentReference globaldoc =
          FirebaseFirestore.instance.collection('crops').doc(cropType);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(globaldoc);

        if (snapshot.exists) {
          int totalQuantity =
              (snapshot.data() as Map<String, dynamic>)['totalQuantity'];

          if (totalQuantity > 1) {
            transaction.update(globaldoc, {'totalQuantity': totalQuantity - 1});
          } else {
            transaction.delete(globaldoc);
          }
        }
      });
      print('Crop deleted successfully!');
      setState(() {});
      _showSnackbar(context, 'Deleted Successfully!');
    } else {
      throw Exception('No user is currently signed in.');
    }
  }
}
