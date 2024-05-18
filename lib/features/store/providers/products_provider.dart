import 'package:flutter/material.dart';
import 'package:smart_farm/features/store/data/store_static_list.dart';
import 'package:smart_farm/features/store/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _products = [];

  List<Product> get products => _products;

  void fetchProducts(String type) {
    _products.clear();
    _products.addAll(productList.where((product) => product.type == type));
    notifyListeners();
  }

  void fetchMyProducts(String type, String id) {
  _products.clear();
  _products.addAll(productList.where((product) => product.type == type && product.sellerId == id));
  notifyListeners();
}

void search(String type, {String? searchString}) {
    _products.clear();
    if (searchString != null && searchString.isNotEmpty) {
      _products.addAll(productList.where((product) => product.type == type && product.name.toLowerCase().contains(searchString.toLowerCase())));
    } else {
      _products.addAll(productList.where((product) => product.type == type));
    }
    notifyListeners();
  }

  void addProduct({
  required String productID,
  required String name,
  required String price,
  required String sellerPhone,
  required String quantity,
  required String description,
  required String sellerId,
  required String image,
  required String type,
  required Map<String, double> location,
}) {
  Product newProduct = Product(
    productID: productID,
    name: name,
    price: price,
    sellerPhone: sellerPhone,
    quantity: quantity,
    description: description,
    sellerId: sellerId,
    image: image,
    type: type,
    location: location,
  );

  _products.add(newProduct);
  notifyListeners();
}

  void deleteProduct(String productID) {
    productList.removeWhere((product) => product.productID == productID);
    notifyListeners();
  }
}
