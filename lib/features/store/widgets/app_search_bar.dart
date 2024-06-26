import 'package:flutter/material.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppSearchBar extends StatelessWidget {
  final Function(String) onSubmitted;

  const AppSearchBar({
    super.key,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations locale = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: TextField(
        cursorColor: Palette.buttonGreen,
        decoration: InputDecoration(
          hintText: locale.search,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.buttonGreen),
            borderRadius: BorderRadius.circular(16),
          ),
          hintStyle: const TextStyle(
            fontFamily: 'poppins',
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          prefixIcon: Transform.scale(
              scale: 1.2,
              child: Image.asset('assets/icons/store_icons/Search.png')),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
