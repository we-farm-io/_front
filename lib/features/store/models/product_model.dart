// I added 3 fields (image, type, location)
class Product {
  final String productID;
  final String name;
  final String price;
  final String sellerPhone;
  final String quantity;
  final String description;
  final String sellerId;
  final String image; // (url)
  final String type; // 'Buy' or 'Rent'
  final Map<String, double> location;
 
  Product ({
    required this.productID,
    required this.name,
    required this.price,
    required this.sellerPhone,
    required this.quantity,
    required this.description,
    required this.sellerId,
    required this.image,
    required this.type,
    required this.location
  });
}
