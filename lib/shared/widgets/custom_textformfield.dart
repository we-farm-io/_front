import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.validator,
  });

  static String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ?? defaultValidator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
        contentPadding: const EdgeInsets.all(14),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Palette.buttonGreen),
        ),
      ),
    );
  }
}
