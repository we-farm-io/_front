import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm/features/store/data/static_list.dart';
import 'package:smart_farm/features/store/models/product_model.dart';

class ProductsProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String productsCollection = 'products';
  // ignore: prefer_final_fields
  List<Product> _products = [];

  List<Product> get products => _products;

  void fetchProducts(String type) async {
    _products.clear();
    try {
      await _firestore
          .collection('products')
          .where('type', isEqualTo: type)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _products.add(Product(
              productID: doc.id,
              name: doc['name'],
              description: doc['description'],
              price: doc['price'],
              sellerPhone: doc['sellerPhone'],
              quantity: doc['quantity'],
              sellerId: doc['sellerId'],
              image: doc['image'],
              type: doc['type'],
              location: {"X": 12}));
        });
      });
    } catch (error) {
      // Handle errors here (e.g., print error message, show a snackbar to the user)
      print("Error getting products: $error");
      // Or return an empty list or a default value
    }

    notifyListeners();
  }

  void fetchMyProducts(String type, String id) {
    _products.clear();
    _products.addAll(productList
        .where((product) => product.type == type && product.sellerId == id));
    notifyListeners();
  }

  Future<void> addProductToCollection(Product product) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('products').add(product.toMap());
    notifyListeners();
  }

  void deleteProduct(String productID) {
    productList.removeWhere((product) => product.productID == productID);
    notifyListeners();
  }
}
