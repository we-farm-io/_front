import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_farm/features/authentication/screens/login_page.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';

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
                const Text(
                  'Success!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 27),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    'Password reset successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(height: 60),
                CustomButton(
                  buttonText: 'Continue',
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
