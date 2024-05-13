import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String svgImage;
  final bool isSelected;

  const CustomIcon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.svgImage,
    required this.isSelected,
  });

  @override
  State<CustomIcon> createState() => _CustomeIconState();
}

class _CustomeIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.svgImage,
              // ignore: deprecated_member_use
              color: widget.isSelected
                  ? const Color.fromRGBO(52, 199, 89, 1)
                  : null,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.text,
              softWrap: false,
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
                overflow: TextOverflow.visible,
                color: widget.isSelected
                    ? const Color.fromRGBO(52, 199, 89, 1)
                    : const Color.fromRGBO(67, 91, 113, 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
