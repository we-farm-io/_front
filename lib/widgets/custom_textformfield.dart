import 'package:flutter/material.dart';
import 'package:smart_farm/pallete.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller; 

  const CustomTextFormField({
    super.key, 
    required this.hintText,
    required this.labelText,
    required this.controller, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, 
      validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
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
          borderSide: const BorderSide(color: Pallete.buttonGreen),
        ),
      ),
    );
  }
}
