// here are the models declared for state management for authentification

import 'package:flutter/material.dart';
import 'package:smart_farm/views/home_page.dart';

class UserViewModel with ChangeNotifier {
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

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }


void loginProvider(
  BuildContext context,
  UserViewModel userViewModel,{
  required String username,
  required String password,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (username.isNotEmpty && password.isNotEmpty) { // replace with actual verification
    // API implementation + errors managing
    userViewModel.setLoginCredentials(username, password);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  } else {
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

  if (phonenumber.isNotEmpty &&
      username.isNotEmpty &&
      password.isNotEmpty &&
      id.isNotEmpty) { // replace with actual verification
    // API implementation + errors managing
    userViewModel.setSignUpCredentials(phonenumber, username, password, id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}

void changePasswordProvider(BuildContext context, UserViewModel userViewModel,
    {required String phonenumber}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (phonenumber.isNotEmpty) { // replace with actual verification
    // API implementation (sending OTP) + errors managing
    userViewModel.setPhoneNumber(phonenumber);
    //Navigator.push(
      //context,
      //MaterialPageRoute(
        //builder: (context) => ChangePasswordPage2(phonenumber: phonenumber),
      //),
    //);
  }
}
}