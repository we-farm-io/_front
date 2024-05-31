// I added 3 fields (image, type, location)
import 'dart:io';

class Product {
  final String productID;
  final String name;
  final double price;
  final String sellerPhone;
  final String quantity;
  final String description;
  final String sellerId;
  final String image;

  final String type; // 'Buy' or 'Rent'
  final Map<String, double> location;

  Product(
      {required this.productID,
      required this.name,
      required this.price,
      required this.sellerPhone,
      required this.quantity,
      required this.description,
      required this.sellerId,
      required this.image,
      required this.type,
      required this.location});

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'name': name,
      'price': price,
      'sellerPhone': sellerPhone,
      'quantity': quantity,
      'description': description,
      'sellerId': sellerId,
      'image': image,
      'type': type,
      'location': location,
    };
  }

  static fromJson(Map<String, dynamic> data) {}
}
