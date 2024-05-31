import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/store/providers/products_provider.dart';
import 'package:smart_farm/features/store/widgets/custom_icon.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  String selectedButton = 'Buy';
  String userID = "3"; // static one for test
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchMyProducts('Buy', userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
        builder: (context, productsProvider, child) {
      return Scaffold(
        appBar: AppBar(
<<<<<<< HEAD
=======
          forceMaterialTransparency: true,
>>>>>>> 016228f62510a86d1d63d614e5fcf0f40432fb43
          title: SvgPicture.asset('assets/logos/AgriTech.svg'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
<<<<<<< HEAD
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const StorePage()),
              );
=======
              Navigator.pop(context);
>>>>>>> 016228f62510a86d1d63d614e5fcf0f40432fb43
            },
            icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/notification_active.svg'),
                onPressed: () {}, // for notifications functionnality
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomIcon(
                    text: 'Rent',
                    isSelected: selectedButton == 'Rent',
                    onPressed: () {
                      selectedButton = 'Rent';
                      productsProvider.fetchMyProducts('Rent', userID);
                    },
                    svgImage: 'assets/icons/store_icons/Rent.svg',
                  ),
                  CustomIcon(
                    text: 'Buy',
                    isSelected: selectedButton == 'Buy',
                    onPressed: () {
                      selectedButton = 'Buy';
                      productsProvider.fetchMyProducts('Buy', userID);
                    },
                    svgImage: 'assets/icons/store_icons/AddProduct.svg',
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "My Products",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(64, 64, 64, 1)),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.52,
                child: ListView.builder(
                  itemCount: productsProvider.products.length,
                  itemBuilder: (context, index) {
                    final product = productsProvider.products[index];
                    return Card(
                      color: Colors.white,
                      elevation: 1,
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                        child: Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.13,
                              width: MediaQuery.of(context).size.height * 0.13,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      product.name,
                                      style: const TextStyle(
                                          fontFamily: 'poppins', fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    product.price as String,
                                    style: const TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25),
                                      child: GestureDetector(
                                        onTap: () {
                                          productsProvider
                                              .deleteProduct(product.productID);
                                          productsProvider.fetchMyProducts(
                                              selectedButton, userID);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 24),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      224, 224, 224, 1)),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontFamily: 'poppins'),
                                            )),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
