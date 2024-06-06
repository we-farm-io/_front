import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/features/profile/models/entity.dart';
import 'package:smart_farm/features/profile/widgets/customentry.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropsPage extends StatefulWidget {
  const CropsPage({super.key});

  @override
  State<CropsPage> createState() => _CropsPageState();
}

User? currentUser = FirebaseAuth.instance.currentUser;
List<Entity> crops = [];

class _CropsPageState extends State<CropsPage> {
  Future<void> addCropToUserProfile(String cropType, int quantity) async {
    if (currentUser != null) {
      String userId = currentUser!.uid;

      DocumentReference cropDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('crops')
          .doc(cropType);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(cropDoc);

        if (!snapshot.exists) {
          transaction.set(cropDoc, {'totalQuantity': quantity});
        } else {
          int newTotalQuantity =
              (snapshot.data() as Map<String, dynamic>)['totalQuantity'] +
                  quantity;
          transaction.update(cropDoc, {'totalQuantity': newTotalQuantity});
        }
      });
      DocumentReference globaldoc =
          FirebaseFirestore.instance.collection('crops').doc(cropType);
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
      setState(() {});
      _showSnackbar(context);
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
          .collection('crops')
          .get();

      crops = snapshot.docs.map((doc) {
        return Entity(
            doc.id, (doc.data() as Map<String, dynamic>)['totalQuantity']);
      }).toList();
    } else {
      throw Exception('No user is currently signed in.');
    }
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

  void _addCrop(BuildContext context, String defaultname, int defaultquantity,
      String action, String buttonaction) {
    String name = defaultname;
    int quantity = defaultquantity;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${action} Crop'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: TextEditingController(text: name),
                onChanged: (value) {
                  name = value;
                },
                decoration: const InputDecoration(labelText: 'Crop Name'),
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
                addCropToUserProfile(name, quantity);

                Navigator.of(context).pop();
              },
              child: Text('${buttonaction}'),
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

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: IconButton(
        icon: SvgPicture.asset("assets/icons/Profile/message-add.svg"),
        onPressed: () {
          _addCrop(context, '', 0, "Add", "Add");
        },
      ),
      body: FutureBuilder(
        future: getUserCrops(),
        builder: (context, snapshot) => Column(
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
                              'assets/icons/Profile/crops_profile.png'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Crops",
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
                              itemCount: crops.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 10),
                                  child: Column(
                                    children: [
                                      Slidable(
                                        key: const ValueKey(0),
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          dismissible: DismissiblePane(
                                            onDismissed: () {
                                              _addCrop(
                                                  context,
                                                  crops[index].name,
                                                  crops[index].value,
                                                  "Edit",
                                                  "Save");
                                            },
                                          ),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {},
                                              icon: Icons.edit,
                                            )
                                          ],
                                        ),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          dismissible: DismissiblePane(
                                            onDismissed: () {},
                                          ),
                                          children: const [],
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30.0),
                                                child: Text(
                                                  crops[index].name,
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
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  decimal: false),
                                              controller:
                                                  TextEditingController(),
                                              style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                hintText: crops[index]
                                                    .value
                                                    .toString(),
                                                hintStyle: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40,
                                                        vertical: 10),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Palette.buttonGreen),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
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
        ),
      ),
    );
  }
}
