import 'package:flutter/material.dart';
import 'package:smart_farm/features/store/widgets/custome_search_delegate.dart';
import 'package:smart_farm/shared/utils/palette.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: TextField(
        cursorColor: Palette.buttonGreen,
        readOnly: true,
        onTap: () { 
          FocusNode().unfocus();
          showSearch(
            context: context,
            delegate: CustomeSerchDelegate());},
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.buttonGreen),
            borderRadius: BorderRadius.circular(16),
          ),
          hintStyle: const TextStyle(
              fontFamily: 'poppins', fontSize: 16,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            //borderSide: const BorderSide(color: Palette.textBlue),
          ),
          prefixIcon: Transform.scale(
              scale: 1.2,
              child: Image.asset('assets/icons/Search.png')),
        ),
      ),
    );
  }
}