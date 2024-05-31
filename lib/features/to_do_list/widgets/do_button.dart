import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class DoButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isSelected;
  const DoButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color color = isSelected ? Palette.buttonGreen : Palette.buttonGreen2;
    return IconButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
