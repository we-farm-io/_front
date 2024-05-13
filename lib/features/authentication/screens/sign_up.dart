import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/authentication/screens/login_page.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:smart_farm/shared/widgets/custom_textformfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  bool _checked = false;
  bool _hidePassword1 = true;
  bool _hidePassword2 = true;

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

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
                    key: userViewModel.signUpFormKey,
                    child: Column(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {},
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
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                            hintText: 'Enter your username',
                            labelText: 'Username',
                            controller: emailController),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
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
                            hintText: 'Enter your password',
                            labelText: 'Password',
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
                              return 'This field is required';
                            } else if (passwordController1.text !=
                                passwordController2.text) {
                              return 'Passwords do not match';
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
                            hintText: 'Enter your password',
                            labelText: 'Confirm Password',
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
                            hintText: 'Enter your ID',
                            labelText: 'User ID',
                            controller: idController),
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
                      const Flexible(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'By signing up you agree to our ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Color.fromRGBO(121, 116, 126, 1),
                                ),
                              ),
                              TextSpan(
                                text: 'terms & conditions of use ',
                                style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 12,
                                  color: Palette.buttonGreen,
                                  //decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: 'and',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Color.fromRGBO(121, 116, 126, 1),
                                ),
                              ),
                              TextSpan(
                                text: ' privacy policy',
                                style: TextStyle(
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
                const SizedBox(height: 20),
                CustomButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    if (!_checked) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please accept the terms & conditions to sign up.'),
                      ));
                    } else {
                      context.read<UserViewModel>().signUpProvider(
                            context,
                            userViewModel,
                            email: emailController.text.trim(),
                            password: passwordController1.text.trim(),
                            id: idController.text.trim(),
                          );
                    }
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color.fromRGBO(175, 175, 175, 1)),
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Log in',
                          style: TextStyle(
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
