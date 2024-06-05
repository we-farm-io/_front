import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/authentication/screens/login_page.dart';
import 'package:smart_farm/shared/services/locale_provider.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:smart_farm/shared/widgets/custom_textformfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  String? countryIsoCode;
  bool _checked = false;
  bool _hidePassword1 = true;
  bool _hidePassword2 = true;

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final localization = AppLocalizations.of(context)!;

    return Consumer<UserViewModel>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'assets/images/authentication_images/signup.svg',
                    height: 240),
                const SizedBox(height: 20),
                SvgPicture.asset('assets/logos/AgriTech.svg'),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InternationalPhoneNumberInput(
                          hintText:
                              AppLocalizations.of(context)!.phoneNumberLogin,
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              countryIsoCode = number.isoCode ?? '';
                            });
                          },
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                          ),
                          textFieldController: phoneController,
                          initialValue: PhoneNumber(isoCode: 'DZ'),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return localization.pleaseEnterAPhoneNumber;
                            } else if (countryIsoCode == "DZ" &&
                                (value.length < 9 || value.length > 10) &&
                                (!RegExp(r'^[765]').hasMatch(
                                    value.startsWith('0')
                                        ? value.substring(1)
                                        : value))) {
                              return localization.invalidPhoneNumber;
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                            hintText: localization.enterYourEmail,
                            labelText: localization.email,
                            controller: emailController),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return localization.thisFieldIsRequired;
                            }
                            return null;
                          },
                          obscureText: _hidePassword1,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword1 = !_hidePassword1;
                                });
                              },
                              icon: Icon(_hidePassword1
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.enterYourPassword,
                            labelText: AppLocalizations.of(context)!.password,
                            contentPadding: const EdgeInsets.all(14),
                            labelStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Palette.buttonGreen),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .thisFieldIsRequired;
                            } else if (passwordController1.text !=
                                passwordController2.text) {
                              return AppLocalizations.of(context)!
                                  .passwordsDoNotMatch;
                            }
                            return null;
                          },
                          obscureText: _hidePassword2,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword2 = !_hidePassword2;
                                });
                              },
                              icon: Icon(_hidePassword2
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.enterYourPassword,
                            labelText:
                                AppLocalizations.of(context)!.confirmPassword,
                            contentPadding: const EdgeInsets.all(14),
                            labelStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Palette.buttonGreen),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hintText: AppLocalizations.of(context)!.enterYourID,
                          labelText: AppLocalizations.of(context)!.userID,
                          controller: idController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourID;
                            }
                            if (value.length != 15) {
                              return AppLocalizations.of(context)!
                                  .invalidIDLength;
                            }
                            return null;
                          },
                        ),
//here we are
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: _checked,
                          onChanged: (value) {
                            setState(() {
                              _checked = value ?? false;
                            });
                          },
                          activeColor: Palette.buttonGreen,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "${AppLocalizations.of(context)!.bySigningUpYouAgreeToOur} ",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Color.fromRGBO(121, 116, 126, 1),
                                ),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .termsAndConditionsOfUse,
                                style: const TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12,
                                  color: Palette.buttonGreen,
                                  //decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: " ${AppLocalizations.of(context)!.and} ",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Color.fromRGBO(121, 116, 126, 1),
                                ),
                              ),
                              TextSpan(
                                text:
                                    AppLocalizations.of(context)!.privacyPolicy,
                                style: const TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12,
                                  color: Palette.buttonGreen,
                                  //decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // here we start
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: CustomButton(
                    buttonText: AppLocalizations.of(context)!.signUp,
                    onPressed: () {
                      if (!_checked) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .pleaseAcceptTheTermsAndConditionsToSignUp),
                        ));
                      } else {
                        if (_formKey.currentState!.validate()) {
                          context.read<UserViewModel>().signUpProvider(
                                context,
                                userViewModel,
                                phonenumber: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController1.text.trim(),
                                id: idController.text.trim(),
                              );
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (Provider.of<LocaleProvider>(context,
                                      listen: false)
                                  .locale
                                  .toString() ==
                              "en") {
                            Provider.of<LocaleProvider>(context, listen: false)
                                .setLocale(const Locale("ar"));
                          } else {
                            Provider.of<LocaleProvider>(context, listen: false)
                                .setLocale(const Locale("en"));
                          }
                        },
                        child: Text(
                            style: const TextStyle(color: Colors.green),
                            Provider.of<LocaleProvider>(context, listen: false)
                                .locale
                                .toString())),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.alreadyHaveAnAccount,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromRGBO(175, 175, 175, 1)),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.logIn,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Palette.buttonGreen),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
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
