import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class InputShadowWithSuffix extends StatefulWidget {
  final TextEditingController controller;
  final Widget suffixIcon;
  final String hintText;
  final bool readOnly;
  final VoidCallback onPressed;

  const InputShadowWithSuffix({
    super.key,
    required this.controller,
    required this.suffixIcon,
    required this.hintText,
    this.readOnly = false,
    required this.onPressed,
  });

  @override
  State<InputShadowWithSuffix> createState() => _InputShadowState();
}

class _InputShadowState extends State<InputShadowWithSuffix> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
        border: Border.all(
          color: Colors.transparent,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            color: Color.fromRGBO(217, 217, 217, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        cursorColor: Palette.buttonGreen,
        controller: widget.controller,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Transform.scale(scale: 0.7, child: widget.suffixIcon),
            onPressed: widget.onPressed,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontFamily: 'poppins'),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            borderRadius: BorderRadius.circular(7.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            borderRadius: BorderRadius.circular(7.5),
          ),
          contentPadding: const EdgeInsets.all(14),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.5),
            borderSide: const BorderSide(
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
        ),
      ),
    );
  }
}
