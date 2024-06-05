import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/authentication/screens/login_page.dart';
import 'package:smart_farm/features/authentication/screens/page1_change_password.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:smart_farm/shared/widgets/custom_textformfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnterMail extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  EnterMail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: SvgPicture.asset('assets/logos/AgriTech.svg'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'assets/images/authentication_images/changepass4.svg',
                  height: 300),
              const SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  AppLocalizations.of(context)!.enter_your_email_to_recieve_reset_password_link,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.enter_your_email,
                        labelText: AppLocalizations.of(context)!.email,
                        controller: emailController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CustomButton(
                  buttonText: AppLocalizations.of(context)!.next,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await userViewModel.sendPasswordResetEmail(
                          context, emailController.text.trim());
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    });
  }
}