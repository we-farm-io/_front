import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/plantdoc/models/plant_data.dart';
import 'package:smart_farm/features/store/models/product_model.dart';
import 'package:smart_farm/features/store/providers/products_provider.dart';
import 'package:smart_farm/features/store/screens/store.dart';
import 'package:smart_farm/features/store/widgets/input_shadow.dart';
import 'package:smart_farm/features/store/widgets/input_shadow_with_suffix.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
            title: SvgPicture.asset('assets/logos/AgriTech.svg'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StorePage()),
                );
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
                  InputShadow(
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
                  InputShadow(
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
                  InputShadow(
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
                  InputShadow(
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
                  InputShadow(
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
                  InputShadowWithSuffix(
                    readOnly: true,
                    controller: locationController,
                    suffixIcon: SvgPicture.asset(
                        'assets/icons/store_icons/location.svg'),
                    hintText: 'Add your location',
                    onPressed: () {},
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
                  InputShadowWithSuffix(
                    readOnly: true,
                    controller: nameController,
                    suffixIcon:
                        Image.asset('assets/icons/store_icons/Upload.png'),
                    hintText: 'Upload image',
                    onPressed: () async {
                      _pickImageFromGallery();
                      print(image_file);
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
                                print(image_file);
                                final mountainsRef =
                                    storageRef.child("images/${uuid.v4()}.jpg");
                                final uploadTask =
                                    mountainsRef.putFile(image_file);
                                final downloadUrl =
                                    await uploadTask.whenComplete(() => null);
                                final url = await mountainsRef.getDownloadURL();
                                Product newProduct = Product(
                                    productID: // static one for test
                                        (productsProvider.products.length + 1)
                                            .toString(),
                                    name: nameController.text.trim(),
                                    price: double.parse(
                                        priceController.text.trim()),
                                    sellerPhone: numberController.text.trim(),
                                    quantity: quantityController.text.trim(),
                                    description:
                                        descriptionController.text.trim(),
                                    sellerId: userID,
                                    image: url,
                                    type: 'Buy',
                                    location: {
                                      'latitude': 37.7749,
                                      'longitude': -122.4194
                                    });
                                ProductsProvider().addProductToCollection(
                                    newProduct); // replace here with values gotten with map APi

                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(16.0),
                                          child: const Text(
                                            "Product added successfully",
                                            style: TextStyle(
                                                fontFamily: 'poppins'),
                                          ));
                                    });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const StorePage()),
                                );
                              })),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.43,
                          child: CustomButton(
                              buttonText: 'Rent',
                              onPressed: () async {
                                final mountainsRef =
                                    storageRef.child("images/${uuid.v4()}.jpg");
                                final uploadTask =
                                    mountainsRef.putFile(image_file);
                                final downloadUrl =
                                    await uploadTask.whenComplete(() => null);
                                final url = await mountainsRef.getDownloadURL();
                                Product newProduct = Product(
                                    productID: // static one for test
                                        (productsProvider.products.length + 1)
                                            .toString(),
                                    name: nameController.text.trim(),
                                    price: double.parse(
                                        priceController.text.trim()),
                                    sellerPhone: numberController.text.trim(),
                                    quantity: quantityController.text.trim(),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const StorePage()),
                                );
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(16.0),
                                          child: const Text(
                                            "Product added successfully",
                                            style: TextStyle(
                                                fontFamily: 'poppins'),
                                          ));
                                    });
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
}
