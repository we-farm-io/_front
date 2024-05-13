import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/store/providers/products_provider.dart';
import 'package:smart_farm/features/store/screens/add_product.dart';
import 'package:smart_farm/features/store/widgets/app_search_bar.dart';
import 'package:smart_farm/features/store/widgets/store_view.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import '../widgets/custome_icon.dart';


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
    Provider.of<ProductsProvider>(context, listen: false).fetchProducts('Buy');
  });
}


  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productsProvider, child) {
        if (productsProvider.products.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: Palette.buttonGreen,));
        } else {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const AppSearchBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomeIcon(
                        text: 'Rent',
                        isSelected: selectedButton == 'Rent',
                        onPressed: () {
                            selectedButton = 'Rent';
                          productsProvider.fetchProducts( 'Rent');
                        },
                        svgImage: 'assets/icons/store_icons/Rent.svg',
                      ),
                      CustomeIcon(
                        text: 'Buy',
                        isSelected: selectedButton == 'Buy',
                        onPressed: () {
                            selectedButton = 'Buy';
                          productsProvider.fetchProducts( 'Buy');
                        },
                        svgImage: 'assets/icons/store_icons/Buy.svg',
                      ),
                      CustomeIcon(
                        text: 'Add product',
                        onPressed: () {
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => const AddProduct())
                          );
                        },
                        svgImage: 'assets/icons/store_icons/AddProduct.svg', isSelected: false,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    height: MediaQuery.of(context).size.height * 0.54,
                    child: StoreView(products: productsProvider.products), 
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
