import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class InputShadow extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const InputShadow({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<InputShadow> createState() => _InputShadowState();
}

class _InputShadowState extends State<InputShadow> {
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
        decoration: InputDecoration(
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
