import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import your localization package

class Input extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final int maxLines;

  const Input({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.maxLines = 1,
  });

  static String? defaultValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.thisFieldIsRequired; // Use the localized string
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator ?? (value) => defaultValidator(context, value), // Pass context to the default validator
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        filled: true,
        fillColor: const Color.fromRGBO(249, 249, 249, 1),
        labelStyle: const TextStyle(fontFamily: 'Poppins', color: Colors.grey),
        contentPadding: const EdgeInsets.all(14),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Palette.buttonGreen),
        ),
      ),
    );
  }
}
