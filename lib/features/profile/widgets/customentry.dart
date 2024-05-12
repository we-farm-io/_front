import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class CustomEntry extends StatelessWidget {
  final String hintText;

  const CustomEntry({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      controller: TextEditingController(),
      style: const TextStyle(
          fontFamily: "Poppins", fontWeight: FontWeight.w600, fontSize: 20),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Palette.buttonGreen),
        ),
      ),
    );
  }
}
