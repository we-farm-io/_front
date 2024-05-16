import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class TextInput extends StatelessWidget {
  final String labelText;
  final Widget? prefixIcon;
  final TextEditingController controller;

  const TextInput({
    super.key,
    required this.labelText,
    this.prefixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      style: const TextStyle(fontFamily: 'poppins'),
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: const Color.fromRGBO(220, 232, 214, 1),
        filled: true,
        prefixIcon: prefixIcon != null
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    prefixIcon!,
                    const SizedBox(width: 8.0),
                    Text(
                      labelText,
                      style: const TextStyle(
                        color: Color.fromRGBO(67, 91, 113, 1),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ],
                ),
            )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  labelText,
                  style: const TextStyle(
                    color: Color.fromRGBO(67, 91, 113, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      cursorColor: Palette.buttonGreen,
    );
  }
}
