import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StoreProductCard extends StatefulWidget {
  const StoreProductCard(
      {super.key,
      required this.svgimagepath,
      required this.name,
      required this.price});

  final String svgimagepath;
  final String name;
  final String price;

  @override
  State<StoreProductCard> createState() => _StoreProductCardState();
}

class _StoreProductCardState extends State<StoreProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.svgimagepath,
              fit: BoxFit.fill,
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(widget.price,
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
    );
  }
}
