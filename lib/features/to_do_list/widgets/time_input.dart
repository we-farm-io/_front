import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeInput extends StatelessWidget {
  final String labelText;
  final Widget suffixIcon;
  final TextEditingController controller;
  final VoidCallback onPressed;

  const TimeInput({
    super.key,
    required this.labelText,
    required this.suffixIcon,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontFamily: 'poppins'
      ),
      readOnly: true,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${AppLocalizations.of(context)!.pleaseEnter} $labelText';
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: const Color.fromRGBO(220, 232, 214, 1),
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8.0),
              Text(
                labelText,
                style: const TextStyle(
                  color: Color.fromRGBO(67, 91, 113, 1),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppins'
                ),
              ),
            ],
          ),
        ), 
        suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: onPressed, icon: suffixIcon)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      cursorColor: Colors.black,
    );
  }
}
