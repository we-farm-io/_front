import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/store/providers/products_provider.dart';
import 'package:smart_farm/features/store/screens/add_product.dart';
import 'package:smart_farm/features/store/widgets/app_search_bar.dart';
import 'package:smart_farm/features/store/widgets/store_view.dart';
import '../widgets/custom_icon.dart';

// ignore: must_be_immutable
class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String selectedButton = 'Buy';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchProducts('Buy');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productsProvider, child) {
        return Scaffold(
          // Added return here
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppSearchBar(
                  onSubmitted: (String searchString) {
                    productsProvider.search(selectedButton,
                        searchString: searchString);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIcon(
                      text: 'Rent',
                      isSelected: selectedButton == 'Rent',
                      onPressed: () {
                        setState(() {
                          selectedButton = 'Rent';
                        });
                        productsProvider.fetchProducts('Rent');
                      },
                      svgImage: 'assets/icons/store_icons/Rent.svg',
                    ),
                    CustomIcon(
                      text: 'Buy',
                      isSelected: selectedButton == 'Buy',
                      onPressed: () {
                        setState(() {
                          selectedButton = 'Buy';
                        });
                        productsProvider.fetchProducts('Buy');
                      },
                      svgImage: 'assets/icons/store_icons/Buy.svg',
                    ),
                    CustomIcon(
                      text: 'Sell',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddProduct()),
                        );
                      },
                      svgImage: 'assets/icons/store_icons/AddProduct.svg',
                      isSelected: false,
                    ),
                  ],
                ),
                if (productsProvider.products.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                   child: Text(
                      'No Products Found',
                      style: TextStyle(
                        color: Color.fromRGBO(67, 91,113,1,),
                          fontFamily: 'poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    height: MediaQuery.of(context).size.height * 0.54,
                    child: StoreView(products: productsProvider.products),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
