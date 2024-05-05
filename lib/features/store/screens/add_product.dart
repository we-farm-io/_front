
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/features/store/widgets/input_shadow.dart';
import 'package:smart_farm/features/store/widgets/maptest.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/logos/AgriTech.svg'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NavBar()),
            );
          },
          icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: SvgPicture.asset('assets/icons/notification_on.svg'),
              onPressed: () {}, // to add notification bar later
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
                suffixIcon: '',
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
                  suffixIcon: '',
                  hintText: 'Add price'),
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
                suffixIcon: '',
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
                suffixIcon: '',
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
              CustomButton(
                onPressed: () {
                  print("tappedLLL");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                  ).then((value) {
                    AddressCombo valeur = value;
                    // This code runs when the SecondPage is popped and returns a value
                    if (value != null) {
                      // Do something with the returned value from SecondPage
                      setState(() {
                        locationController.text = valeur.address!;
                      });
                      //todo handle firebase store location of product
                    }
                  });
                },
                buttonText: locationController.text,
                // child: InputShadow(
                //   readOnly: true,
                //   controller: locationController,
                //   suffixIcon: 'assets/icons/upload.svg',
                //   hintText: 'Add your location',
                // ),
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
              InputShadow(
                readOnly: true,
                controller: nameController,
                suffixIcon: 'assets/icons/upload.svg',
                hintText: 'Upload image',
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.43,
                      child:
                          CustomButton(buttonText: 'Sell', onPressed: () {})),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.43,
                      child:
                          CustomButton(buttonText: 'Rent', onPressed: () {})),
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
  }
}
