import 'package:smart_farm/features/store/models/product_model.dart';

const String tractorimage =
    "https://www.news-jd.com/wp-content/uploads/2022/11/John-Deere-won-two-CES-2023-Innovation-Awards.jpg";
const String cropsimage =
    "https://thumbs.dreamstime.com/z/collection-de-pile-organique-s%C3%A8che-c%C3%A9r%C3%A9ales-et-graines-dans-le-ton-sombre-pour-concept-d-ingr%C3%A9dients-alimentaires-sain-propre-211767238.jpg?ct=jpeg";
const String cowimage =
    "https://images.voicy.network/Content/Pages/Images/bc9c02f6-864d-4134-be9e-bd105c6b37f5-small.png?auto=compress&auto=format&h=186&lossless=true&auto=compress&auto=format&w=560";
const String cornimage =
    "https://i0.wp.com/cdn.algeriemaintenant.dz/wp-content/uploads/2020/11/123736678_183451466690557_2503183553690422991_n.jpg?ssl=1&w=1248";

List<Product> productList = [
  Product(
    productID: "0",
    name: "corn crop",
    price: "650 da",
    sellerPhone: "+213567890123",
    quantity: "20 kg",
    description:
        "Prime-grade corn, meticulously harvested at optimal ripeness, delivering superior sweetness and tenderness for culinary excellence",
    sellerId: "0",
    image: cornimage,
    type: "Rent",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "1",
    name: "cow",
    price: "250000 da",
    sellerPhone: "+213565890123",
    quantity: "1",
    description:
        "This Holstein Cow is 7 years old, weighs 315 kg and milks about 25 liters of milk per day, it doesn’t suffer from any disease.",
    sellerId: "1",
    image: cowimage,
    type: "Buy",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "2",
    name: "different crops",
    price: "1500 da",
    sellerPhone: "+213657890123",
    quantity: "60 kg",
    description:
        "Prime-grade crops, meticulously harvested at optimal ripeness, delivering superior sweetness and tenderness for culinary excellence.",
    sellerId: "3",
    image: cropsimage,
    type: "Rent",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "3",
    name: "tractor",
    price: "4000000 da",
    sellerPhone: "+213765890123",
    quantity: "1",
    description:
        "Reliable and robust, a top-tier tractor boasts superior performance, ensuring efficiency and productivity for the agricultural needs.",
    sellerId: "3",
    image: tractorimage,
    type: "Buy",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "4",
    name: "different crops",
    price: "1500 da",
    sellerPhone: "+213657890123",
    quantity: "60 kg",
    description:
        "Prime-grade crops, meticulously harvested at optimal ripeness, delivering superior sweetness and tenderness for culinary excellence.",
    sellerId: "3",
    image: cropsimage,
    type: "Buy",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "5",
    name: "cow",
    price: "250000 da",
    sellerPhone: "+213565890123",
    quantity: "1",
    description:
        "This Holstein Cow is 7 years old, weighs 315 kg and milks about 25 liters of milk per day, it doesn’t suffer from any disease.",
    sellerId: "5",
    image: cowimage,
    type: "Buy",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "6",
    name: "tractor",
    price: "4000000 da",
    sellerPhone: "+213765890123",
    quantity: "1",
    description:
        "Reliable and robust, a top-tier tractor boasts superior performance, ensuring efficiency and productivity for the agricultural needs.",
    sellerId: "0",
    image: tractorimage,
    type: "Rent",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "7",
    name: "tractor",
    price: "4000000 da",
    sellerPhone: "+213765890123",
    quantity: "1",
    description:
        "Reliable and robust, a top-tier tractor boasts superior performance, ensuring efficiency and productivity for the agricultural needs.",
    sellerId: "1",
    image: tractorimage,
    type: "Buy",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "8",
    name: "corn crop",
    price: "650 da",
    sellerPhone: "+213567890123",
    quantity: "20 kg",
    description:
        "Prime-grade corn, meticulously harvested at optimal ripeness, delivering superior sweetness and tenderness for culinary excellence.",
    sellerId: "8",
    image: cornimage,
    type: "Rent",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "9",
    name: "cow",
    price: "250000 da",
    sellerPhone: "+213565890123",
    quantity: "1",
    description:
        "This Holstein Cow is 7 years old, weighs 315 kg and milks about 25 liters of milk per day, it doesn’t suffer from any disease.",
    sellerId: "3",
    image: cowimage,
    type: "Rent",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "10",
    name: "tractor",
    price: "4000000 da",
    sellerPhone: "+213765890123",
    quantity: "1",
    description:
        "Reliable and robust, a top-tier tractor boasts superior performance, ensuring efficiency and productivity for the agricultural needs.",
    sellerId: "10",
    image: tractorimage,
    type: "Rent",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "11",
    name: "tractor",
    price: "4000000 da",
    sellerPhone: "+213765890123",
    quantity: "1",
    description:
        "Reliable and robust, a top-tier tractor boasts superior performance, ensuring efficiency and productivity for the agricultural needs.",
    sellerId: "3",
    image: tractorimage,
    type: "Rent",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "12",
    name: "corn crop",
    price: "650 da",
    sellerPhone: "+213567890123",
    quantity: "20 kg",
    description:
        "Prime-grade corn, meticulously harvested at optimal ripeness, delivering superior sweetness and tenderness for culinary excellence.",
    sellerId: "3",
    image: cornimage,
    type: "Buy",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
  Product(
    productID: "13",
    name: "cow",
    price: "250000 da",
    sellerPhone: "+213565890123",
    quantity: "1",
    description:
        "This Holstein Cow is 7 years old, weighs 315 kg and milks about 25 liters of milk per day, it doesn’t suffer from any disease.",
    sellerId: "13",
    image: cowimage,
    type: "Rent",
    location: {'latitude': 37.7749, 'longitude': -122.4194},
  ),
];
