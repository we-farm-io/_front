import 'dart:convert';

List<Products> productFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

class Products {
    final String id;
    final String name;
    final String category;
    final String image;
    final String price;
    final String description;
    final String title;
    final String quantity;

    Products({
        required this.id,
        required this.name,
        required this.category,
        required this.image,
        required this.price,
        required this.description,
        required this.title,
        required this.quantity,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        image: json["Image"],
        price: json["price"],
        description: json["description"],
        title: json["title"],
        quantity: json["quantity"],
    );
}