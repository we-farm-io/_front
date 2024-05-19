import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/profile/screens/profile.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';
import 'package:smart_farm/shared/widgets/custom_textformfield.dart';

class ChangePasswordProfile extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController newpasswordController1 = TextEditingController();
  final TextEditingController newpasswordController2 = TextEditingController();

  ChangePasswordProfile({super.key});
 
  @override
  Widget build(BuildContext context) {
    String userID = "3"; // static one for test
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) => Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: SvgPicture.asset('assets/logos/AgriTech.svg'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
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
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomTextFormField(
                        hintText: 'Enter your old password',
                        labelText: 'old password',
                        controller: oldpasswordController,
                        validator: (value) {
                          final enteredPassword =
                              oldpasswordController.text.trim();
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          } else if (!userViewModel.oldPasswordCorrect(
                              userID, enteredPassword)) {
                            return 'password is incorrect';
                          }
                          return null;
                        },
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: CustomTextFormField(
                          hintText: 'Confirm your new password',
                          labelText: 'new password',
                          controller: newpasswordController2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            } else if (newpasswordController2.text !=
                                newpasswordController1.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 52),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CustomButton(
                  buttonText: 'Next',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<UserViewModel>().changePasswordProvider(
                          context, userViewModel,
                          newpassword: newpasswordController1.text.trim());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Success()));
                    }
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

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: SvgPicture.asset('assets/logos/AgriTech.svg'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
          icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
        ),
      ),
      body: Column(
        children: [
          SvgPicture.asset(
              'assets/images/authentication_images/Verified-profile.svg'),
          const SizedBox(height: 24),
          const Text(
            'Success!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: const Text(
              'your password changed successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
