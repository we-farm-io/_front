import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_farm/features/store/screens/product_details.dart';
import 'package:smart_farm/features/store/widgets/store_product_card.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import '../models/product_model.dart';

class StoreView extends StatelessWidget {
  const StoreView({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        color: Palette.buttonGreen,
      ));
    } else {
      return StaggeredGridView.countBuilder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          print(products);
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
}
