import 'package:flutter/material.dart';

class CustomeIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Image pngImage;

  const CustomeIcon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.pngImage,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          pngImage,
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              //color: Palette.textBlue,
              fontFamily: 'poppins',
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}