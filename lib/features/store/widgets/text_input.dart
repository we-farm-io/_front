import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int? theMaxLines;

  const TextInput({
    super.key, 
    required this.controller,
    required this.hintText,
    this.theMaxLines = 1,
  }); 

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.theMaxLines,
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
    );
  }
}
