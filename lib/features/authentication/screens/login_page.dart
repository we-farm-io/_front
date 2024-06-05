import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/authentication/screens/enter_mail.dart';
import 'package:smart_farm/features/authentication/screens/sign_up.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:smart_farm/shared/widgets/custom_textformfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_farm/shared/services/locale_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _hidePassword = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final userViewModel = Provider.of<UserViewModel>(context);

    return Consumer<UserViewModel>(
      builder: (context, value, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'assets/images/authentication_images/login.svg',
                    height: 275),
                SvgPicture.asset('assets/logos/AgriTech.svg'),
                const SizedBox(height: 40),
                Container(
                  alignment: isEnglish ? Alignment.topLeft : Alignment.topRight,
                  padding: isEnglish
                      ? const EdgeInsets.only(left: 25)
                      : const EdgeInsets.only(right: 25),
                  child: Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  alignment: isEnglish ? Alignment.topLeft : Alignment.topRight,
                  padding: isEnglish
                      ? const EdgeInsets.only(left: 25)
                      : const EdgeInsets.only(right: 25),
                  child: Text(
                    AppLocalizations.of(context)!.loginto_account,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                            hintText:
                                AppLocalizations.of(context)!.enter_your_email,
                            labelText: AppLocalizations.of(context)!.email,
                            controller: emailController),
                        const SizedBox(height: 26),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          obscureText: _hidePassword,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: Icon(_hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: AppLocalizations.of(context)!
                                .enter_your_password,
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 11.46),
                GestureDetector(
                  child: Container(
                    alignment:
                        isEnglish ? Alignment.topLeft : Alignment.topRight,
                    padding: isEnglish
                        ? const EdgeInsets.only(left: 25)
                        : const EdgeInsets.only(right: 25),
                    child: Text(
                      AppLocalizations.of(context)!.forgot_password,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Palette.buttonGreen,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnterMail(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomButton(
                    buttonText: AppLocalizations.of(context)!.log_in,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<UserViewModel>().loginProvider(
                            context, userViewModel,
                            email: emailController.text.trim(),
                            password: passwordController.text);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
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
                          AppLocalizations.of(context)!.dont_have_an_account,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            AppLocalizations.of(context)!.sign_up,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Palette.buttonGreen,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
