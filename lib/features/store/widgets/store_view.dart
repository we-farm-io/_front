import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_farm/features/store/screens/product_details.dart';
import 'package:smart_farm/features/store/widgets/store_product_card.dart';
import '../models/product_model.dart';

class StoreView extends StatelessWidget {
  const StoreView({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          product: product,
                        )));
          },
          child: StoreProductCard(
            name: product.name,
            price: product.price,
            imageurl: product.image,
          ),
        );
      },
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
    );
  }
}
