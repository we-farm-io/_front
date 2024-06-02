import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:smart_farm/features/plantdoc/models/plant_data.dart';
import 'package:smart_farm/features/store/models/product_model.dart';
import 'package:smart_farm/features/store/providers/products_provider.dart';
// ignore: unused_import
import 'package:smart_farm/features/store/screens/store.dart';
import 'package:smart_farm/features/store/widgets/text_input.dart';
import 'package:smart_farm/features/store/widgets/input_with_suffix.dart';
import 'package:smart_farm/features/store/widgets/maptest.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final picker = ImagePicker();
  // ignore: non_constant_identifier_names
  File image_file = File("");
  final storageRef =
      FirebaseStorage.instanceFor(bucket: 'gs://farmai-e033e.appspot.com')
          .ref();
  var uuid = Uuid();
  LatLng coordinate = LatLng(0, 0);
  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

// Retrieve the user ID
    String userID = currentUser!.uid;
    return Consumer<ProductsProvider>(
      builder: (context, productsProvider, child) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: SvgPicture.asset('assets/logos/AgriTech.svg'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
            ),
            actions: [
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon:
                      SvgPicture.asset('assets/icons/notification_active.svg'),
                  onPressed: () {}, // for notifications functionnality
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                        ),
                        const Text(
                          'Add your product',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset('assets/images/store/Group.png')
                      ],
                    ),
                    const Text(
                      'Product name',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextInput(
                      controller: nameController,
                      hintText: 'Add product name',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextInput(
                      controller: priceController,
                      hintText: 'Add price',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextInput(
                      controller: quantityController,
                      hintText: 'Add quantity',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextInput(
                      theMaxLines: null,
                      controller: descriptionController,
                      hintText: 'Add description',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Phone number',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextInput(
                      controller: numberController,
                      hintText: 'Add your phone number',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InputWithSuffix(
                      readOnly: true,
                      controller: locationController,
                      suffixIcon: SvgPicture.asset(
                          'assets/icons/store_icons/location.svg'),
                      hintText: 'Add your location',
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                              builder: (context) => const NavigationPage()),
                        )
                            .then((value) {
                          AddressCombo valeur = value;
                          if (value != null) {
                            setState(() {
                              locationController.text = valeur.address!;
                              if (valeur.coordinates != null) {
                                coordinate = valeur.coordinates!;
                              } else {}
                            });
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Product image',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InputWithSuffix(
                      readOnly: true,
                      controller: nameController,
                      suffixIcon:
                          Image.asset('assets/icons/store_icons/Upload.png'),
                      hintText: 'Upload image',
                      onPressed: () async {
                        _pickImageFromGallery();
                        imageController.text = "${nameController.text}_image";
                      },
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: CustomButton(
                                buttonText: 'Sell',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final mountainsRef = storageRef
                                        .child("images/${uuid.v4()}.jpg");
                                    final uploadTask =
                                        mountainsRef.putFile(image_file);
                                    // ignore: unused_local_variable
                                    final downloadUrl = await uploadTask
                                        .whenComplete(() => null);
                                    final url =
                                        await mountainsRef.getDownloadURL();
                                    Product newProduct = Product(
                                        productID: // static one for test
                                            (productsProvider.products.length +
                                                    1)
                                                .toString(),
                                        name: nameController.text.trim(),
                                        price: double.parse(
                                            priceController.text.trim()),
                                        sellerPhone:
                                            numberController.text.trim(),
                                        quantity:
                                            quantityController.text.trim(),
                                        description:
                                            descriptionController.text.trim(),
                                        sellerId: userID,
                                        image: url,
                                        type: 'Buy',
                                        location: {
                                          'latitude': coordinate.latitude,
                                          'longitude': coordinate.longitude
                                        });
                                    ProductsProvider().addProductToCollection(
                                        newProduct); // replace here with values gotten with map APi
                                    Navigator.of(context).pop();
                                    _showSuccessDialog();
                                  }
                                })),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: CustomButton(
                                buttonText: 'Rent',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final mountainsRef = storageRef
                                        .child("images/${uuid.v4()}.jpg");
                                    final uploadTask =
                                        mountainsRef.putFile(image_file);
                                    final downloadUrl = await uploadTask
                                        .whenComplete(() => null);
                                    final url =
                                        await mountainsRef.getDownloadURL();
                                    Product newProduct = Product(
                                        productID: // static one for test
                                            (productsProvider.products.length +
                                                    1)
                                                .toString(),
                                        name: nameController.text.trim(),
                                        price: double.parse(
                                            priceController.text.trim()),
                                        sellerPhone:
                                            numberController.text.trim(),
                                        quantity:
                                            quantityController.text.trim(),
                                        description:
                                            descriptionController.text.trim(),
                                        sellerId: userID,
                                        image:
                                            url, // replace with uploaded image saved with firebase
                                        type: 'Rent',
                                        location: {
                                          'latitude': 37.7749,
                                          'longitude': -122.4194
                                        } // replace here with values gotten with map APi
                                        );
                                    ProductsProvider()
                                        .addProductToCollection(newProduct);
                                    Navigator.of(context).pop();
                                    _showSuccessDialog();
                                  }
                                }))
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<File> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image_file = File(pickedFile.path);
      });

      return image_file;
      // Todo: You can prompt user to input disease, definition, and solution here.
    } else {
      return File("");
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SvgPicture.asset('assets/icons/Vector_Done.svg'),
          content: const Text(
            'Product added successfully',
            style: TextStyle(fontFamily: 'poppins'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    fontFamily: 'poppins', color: Palette.buttonGreen),
              ),
            ),
          ],
        );
      },
    );
  }
}
