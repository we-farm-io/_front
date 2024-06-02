import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class SendButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const SendButton({
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
          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(52, 199, 89, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
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
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}