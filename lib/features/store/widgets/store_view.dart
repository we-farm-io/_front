import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_farm/features/store/models/store.model.dart';
import 'package:smart_farm/features/store/widgets/store_product_card.dart';

class StoreView extends StatelessWidget {
  const StoreView({
    super.key,
    required Future<List<Products>> products,
  }) : _products = products;

  final Future<List<Products>> _products;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        } else {
          final products = snapshot.data;
          return StaggeredGridView.countBuilder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                final shoe = snapshot.data![index];

                print(shoe);
                return StoreProductCard(
                  name: shoe.name,
                  price: "\$${shoe.price}",
                  svgimagepath: shoe.image,
                );
              },
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              staggeredTileBuilder: (index) => StaggeredTile.extent(
                    (index % 2 == 0) ? 1 : 1,
                    MediaQuery.of(context).size.height * 0.4,
                  ));
        }
      },
    );
  }
}
