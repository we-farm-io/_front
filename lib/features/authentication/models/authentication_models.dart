import 'package:flutter/material.dart';
import 'package:smart_farm/features/authentication/screens/page2_change_password.dart';
import 'package:smart_farm/features/authentication/screens/page3_change_password.dart';
import 'package:smart_farm/features/authentication/screens/success_auth.dart';
import 'package:smart_farm/features/authentication/screens/success_change_password.dart';
import 'package:smart_farm/features/home/screens/home.dart';

class UserViewModel with ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final page1FormKey = GlobalKey<FormState>();
  final page3FormKey = GlobalKey<FormState>();


  String? username;
  String? password;
  String? phonenumber;
  String? id;
  String? errorMessage; 

  void setLoginCredentials(String username, String password) {
    this.username = username;
    this.password = password;
    errorMessage = null;
    notifyListeners();
  }

  void setSignUpCredentials(
      String phonenumber, String username, String password, String id) {
    this.phonenumber = phonenumber;
    this.username = username;
    this.password = password;
    this.id = id;
    errorMessage = null;
    notifyListeners();
  }

  void setPhoneNumber(String phonenumber) {
    this.phonenumber = phonenumber;
    errorMessage = null;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    errorMessage = null;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void loginProvider(
    BuildContext context,
    UserViewModel userViewModel, {
    required String username,
    required String password,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (loginFormKey.currentState?.validate() ?? false) {
      // replace with actual verification
      // API implementation + errors managing
      userViewModel.setLoginCredentials(username, password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (username.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username or pasword is incorrect'),
        ),
      );
    }
  }

  void signUpProvider(BuildContext context, UserViewModel userViewModel,
      {required String phonenumber,
      required String username,
      required String password,
      required String id}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (signUpFormKey.currentState?.validate() ?? false) {
      // replace with actual verification
      // API implementation + errors managing
      userViewModel.setSignUpCredentials(phonenumber, username, password, id);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessAuth()),
      );
    }
  } 

  void sendOTPProvider(BuildContext context, UserViewModel userViewModel,
      {required String phonenumber}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (page1FormKey.currentState?.validate() ?? false) {
      // replace with actual verification with the phone in database
      userViewModel.setPhoneNumber(phonenumber);
      // API implementation (sending OTP) + errors managing
      String sentOTP = '1234'; // replace with actual sendig OTP process
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Page2ChangePassword(phonenumber: phonenumber, sentOTP: sentOTP),
        ),
      );
    }
  }

  void verifyOTP(
    BuildContext context,
    UserViewModel userViewModel, {
    required String phonenumber,
    required String sentOTP, // replace with actual sentOTP
    required String enteredOTP,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (sentOTP == enteredOTP) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Page3ChangePassword(phonenumber: phonenumber),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect OTP'),
        ),
      );
    }
  }

  void changePasswordProvider(BuildContext context, UserViewModel userViewModel,
      {required String newpassword}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (page3FormKey.currentState!.validate()) {
      userViewModel.setPassword(newpassword); // + modify in database
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessChangePassword(),
        ),
      );
    }
  }
}
