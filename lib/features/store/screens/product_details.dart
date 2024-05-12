// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/store/models/product_model.dart';
import 'package:smart_farm/features/store/providers/products_provider.dart';
import 'package:smart_farm/features/store/screens/store.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productsProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavBar()),
                );
              },
              icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
            ),
            title: const Text(
              'Details',
              style: TextStyle(
                color: Color.fromRGBO(13, 13, 14, 1),
                fontFamily: 'poppins',
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.price,
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'About',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 14,
                      color: Color.fromRGBO(67, 91, 113, 1),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Color.fromRGBO(146, 227, 169, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Location Details'),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: 72.0,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(52, 199, 89, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(83),
                              bottomLeft: Radius.circular(83),
                              topRight: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await launchUrl(Uri.parse(
                                  //Todo implement the fetch product coordinates and link with firebase
                                  'google.navigation:q=${35.7048287}, ${-0.653571}&key=AIzaSyDSbl052WrQ8pwywEKmNl5FLJAa21tXxa0'));
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    buttonText: 'Contact Seller',
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.phone),
                                      onPressed: () {
                                        launch('tel:${product.sellerPhone}');
                                      },
                                    ),
                                    Text(product.sellerPhone),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
