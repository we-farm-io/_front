import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class CustomButtonProfile extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButtonProfile({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Palette.buttonGreen),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 13),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
