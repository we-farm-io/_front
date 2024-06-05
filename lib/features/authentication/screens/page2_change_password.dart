import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:smart_farm/shared/widgets/custom_textformfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Page2ChangePassword extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

  Page2ChangePassword({super.key, required String email});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'assets/images/authentication_images/changepass4.svg',
                  height: 300),
              SvgPicture.asset('assets/logos/AgriTech.svg'),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 25),
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
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.enter_your_new_password,
                        labelText: AppLocalizations.of(context)!.new_password,
                        controller: passwordController1,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: passwordController2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.this_field_is_required;
                          } else if (passwordController2.text !=
                              passwordController1.text) {
                            return AppLocalizations.of(context)!.passwords_do_not_match;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: AppLocalizations.of(context)!.enter_your_new_password,
                          labelText: AppLocalizations.of(context)!.confirm_password,
                          labelStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.all(14),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: Palette.buttonGreen),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 52),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CustomButton(
                  buttonText: AppLocalizations.of(context)!.next,
                  onPressed: () {
                    //{if (_formKey.currentState!.validate()) {
                    //context.read<UserViewModel>().changePasswordProvider(
                    //  context, userViewModel,
                    //newPassword: passwordController1.text.trim());
                    //}}
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}