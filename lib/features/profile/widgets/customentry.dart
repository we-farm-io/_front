import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class CustomEntry extends StatelessWidget {
  final String hintText;
  final String cropsName;
  const CustomEntry({
    super.key,
    required this.hintText,
    required this.cropsName,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
          },
        ),
        children: [],
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                cropsName,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          TextField(
            readOnly: true,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            controller: TextEditingController(),
            style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 20),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: hintText,
              hintStyle:
                  const TextStyle(fontFamily: 'Poppins', color: Colors.black),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Palette.buttonGreen),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
