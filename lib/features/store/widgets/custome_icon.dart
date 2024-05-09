import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomeIcon extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String svgImage;
  final bool isSelected;

  const CustomeIcon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.svgImage,
    required this.isSelected ,
  });

  @override
  State<CustomeIcon> createState() => _CustomeIconState();
}

class _CustomeIconState extends State<CustomeIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            widget.svgImage,
            // ignore: deprecated_member_use
            color: widget.isSelected ? const Color.fromRGBO(52, 199, 89, 1) : null,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 14,
              color: widget.isSelected ? const Color.fromRGBO(52, 199, 89, 1) : const Color.fromRGBO(67, 91, 113, 1),
            ),
          )
        ],
      ),
    );
  }
}
