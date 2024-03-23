import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models.authentication/authentication_models.dart';
import 'package:smart_farm/features/authentication/screens/auth.screens/sign_up.dart';
import 'package:smart_farm/pallete.dart';
import 'package:smart_farm/widgets/custom_button.dart';
import 'package:smart_farm/widgets/custom_textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Consumer<UserViewModel>(
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
      builder: (context, UserViewModel, child) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/authentication_images/login.svg', height: 275),
                SvgPicture.asset('assets/logos/AgriTech.svg'),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25),
                  child: const Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25),
                  child: const Text(
                    'Log into your account',
                    style: TextStyle(
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
                    child: Column(
                      children: [
                        CustomTextFormField(
                            hintText: 'Enter your username',
                            labelText: 'Username',
                            controller: usernameController),
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
                                  const BorderSide(color: Pallete.buttonGreen),
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
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 25),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Pallete.buttonGreen,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ChangePassword()),
                    // );
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  buttonText: 'Log in',
                  onPressed: () {
                    final username = usernameController.text.trim();
                    final password = passwordController.text.trim();
                    UserViewModel.loginProvider(context, userViewModel,
                        username: username, password: password);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account? ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(175, 175, 175, 1),
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Pallete.buttonGreen,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
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
