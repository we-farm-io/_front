import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StoreProductCard extends StatefulWidget {
  const StoreProductCard(
      {super.key,
      required this.imageurl,
      required this.name,
      required this.price});

  final String imageurl;
  final String name;
  final double price;

  @override
  State<StoreProductCard> createState() => _StoreProductCardState();
}

class _StoreProductCardState extends State<StoreProductCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.imageurl,
                    fit: BoxFit.fill,
                  )),
=======
              SizedBox(
                height: 150,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.imageurl,
                      fit: BoxFit.cover,
                    )),
              ),
>>>>>>> 016228f62510a86d1d63d614e5fcf0f40432fb43
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
<<<<<<< HEAD
                      widget.price.toString(),
=======
                      widget.price,
>>>>>>> 016228f62510a86d1d63d614e5fcf0f40432fb43
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    Text(widget.name,
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
          bottom: 42,
          left: MediaQuery.of(context).size.width * 0.3,
          child: Container(
            color: Colors.transparent,
            height: 36,
            width: 40,
            child: SvgPicture.asset('assets/icons/store_icons/Cart.svg'),
          )),
    ]);
  }
}
