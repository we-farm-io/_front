import 'package:flutter/services.dart' as service;
import 'package:smart_farm/features/store/models/store.model.dart';

// this class fetches data from json file and return it to the app
class Helper{
  Future<List<Products>> getProductsList() async {
    final data = 
       await service.rootBundle.loadString("assets/json/store_products.json");

       final productList = productFromJson(data);

       return productList;
  }

  Future<Products> getProduct(String id) async {
    final data = 
       await service.rootBundle.loadString("assets/json/store_products.json");

       final productList = productFromJson(data);

       final product = productList.firstWhere((sneaker) => sneaker.id == id);

       return product;
  }

}