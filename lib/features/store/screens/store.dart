import 'package:flutter/material.dart';
import 'package:smart_farm/features/store/models/store.model.dart';
import 'package:smart_farm/features/store/screens/add_product.dart';
import 'package:smart_farm/features/store/widgets/app_search_bar.dart';
import 'package:smart_farm/features/store/widgets/custome_icon.dart';
import 'package:smart_farm/features/store/widgets/store_view.dart';
import 'package:smart_farm/shared/services/store.helper.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late Future<List<Products>> _products;

  void getProducts() {
    _products = Helper().getProductsList();
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const AppSearchBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomeIcon(
                  text: 'Rent',
                  onPressed: () {},
                  pngImage: Image.asset('assets/icons/Rent.png')),
              CustomeIcon(
                  text: 'Buy',
                  onPressed: () {},
                  pngImage: Image.asset('assets/icons/Buy.png')),
              CustomeIcon(
                  text: 'Add product',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProduct()),
                    );
                  },
                  pngImage: Image.asset('assets/icons/AddProduct.png')),
            ],
          ),
          Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.54,
              child: StoreView(
                products: _products,
              )),
        ]),
      ),
    );
  }
}
