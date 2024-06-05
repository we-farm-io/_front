import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_farm/features/authentication/screens/login_page.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessChangePassword extends StatelessWidget {
  const SuccessChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                SvgPicture.asset('assets/logos/AgriTech.svg'),
                const SizedBox(height: 30),
                SvgPicture.asset('assets/images/authentication_images/success.svg', height: 380),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.success,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 27),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    AppLocalizations.of(context)!.passwordResetSuccessfully,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(height: 60),
                CustomButton(
                  buttonText: AppLocalizations.of(context)!.continueText,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}