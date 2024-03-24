import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models.authentication/authentication_models.dart';
import 'package:smart_farm/pallete.dart';
import 'package:smart_farm/widgets/custom_button.dart';
import 'package:smart_farm/widgets/custom_textformfield.dart';

class Page3ChangePassword extends StatelessWidget {
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

  Page3ChangePassword({super.key, required String phonenumber});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Consumer<UserViewModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(),
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
                child: const Text(
                  'Change Password',
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
                key: userViewModel.page3FormKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomTextFormField(
                        hintText: 'Enter your new password',
                        labelText: 'new password',
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
                            return 'This field is required';
                          } else if (passwordController2.text !=
                              passwordController1.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter your new password',
                          labelText: 'Confirm password',
                          labelStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.all(14),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: Pallete.buttonGreen),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              CustomButton(
                buttonText: 'Next',
                onPressed: () {
                  context.read<UserViewModel>().changePasswordProvider(
                      context, userViewModel,
                      newpassword: passwordController1.text.trim());
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
