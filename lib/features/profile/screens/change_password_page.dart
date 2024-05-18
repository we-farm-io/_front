import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:smart_farm/shared/widgets/custom_textformfield.dart';

class ChangePasswordProfile extends StatelessWidget {
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController newpasswordController1 = TextEditingController();
  final TextEditingController newpasswordController2 = TextEditingController();

  ChangePasswordProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) => Scaffold(
        body: Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset('assets/logos/AgriTech.svg'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                  key: userViewModel.page2FormKey,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: CustomTextFormField(
                          hintText: 'Enter your old password',
                          labelText: 'old password',
                          controller: oldpasswordController,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: CustomTextFormField(
                          hintText: 'Enter your new password',
                          labelText: 'new password',
                          controller: newpasswordController1,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: newpasswordController2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            } else if (newpasswordController2.text !=
                                newpasswordController1.text) {
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
                    buttonText: 'Next',
                    onPressed: () {
                      context.read<UserViewModel>().changePasswordProvider(
                          context, userViewModel,
                          newpassword: newpasswordController1.text.trim());
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
