import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/authentication/screens/page2_change_password.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.change_password,
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
                  child: Text(
                    AppLocalizations.of(context)!
                        .we_have_sent_you_a_link_in_your_email_that_you_can_click_on_to_change_your_password,
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
                  child: Text(
                    AppLocalizations.of(context)!.resend,
                    style: TextStyle(
                        color: Palette.buttonGreen,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    userViewModel.sendPasswordResetEmail(context, email);
                  },
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: CustomButton(
                    buttonText: AppLocalizations.of(context)!.check_email,
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
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .please_check_the_link_sent_to_your_email),
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
