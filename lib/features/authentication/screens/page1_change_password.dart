import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/authentication/screens/page2_change_password.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';

// ignore: must_be_immutable
class Page1ChangePassword extends StatelessWidget {
  String email;
  Page1ChangePassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'assets/images/authentication_images/changepass.svg',
                    height: 300),
                SvgPicture.asset('assets/logos/AgriTech.svg'),
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25),
                  child: const Center(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: const Text(
                    'We have sent you a link in your email that you can click on to change your password .',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  child: const Text(
                    'Resend',
                    style: TextStyle(
                        color: Palette.buttonGreen,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    userViewModel.sendPasswordResetEmail(
                        context, userViewModel.email!);
                  },
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: CustomButton(
                    buttonText: 'Check Email',
                    onPressed: () {
                      if (userViewModel.linkChecked()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Page2ChangePassword(
                              email: email,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please check the link sent to your email'),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
