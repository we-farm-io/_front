import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm/features/authentication/models/user.dart';
import 'package:smart_farm/features/authentication/screens/page2_change_password.dart';
import 'package:smart_farm/features/authentication/screens/page3_change_password.dart';
import 'package:smart_farm/features/authentication/screens/success_auth.dart';
import 'package:smart_farm/features/authentication/screens/success_change_password.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';

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
  Userclass? _userFromFirebaseUser(User user) {
    return user != null ? Userclass(uid: user.uid) : null;
  }

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
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: username, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "No User Found for that Email",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Wrong Password Provided by User",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
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
      if (password.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password Provided is too short",
              style: TextStyle(fontSize: 18.0),
            )));
      } else {
        try {
          UserCredential usercredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: username, password: password);
          User? user = usercredential.user;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessAuth()),
          );
          // Navigate to the next screen upon successful sign-up
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Password Provided is too Weak",
                  style: TextStyle(fontSize: 18.0),
                )));
          } else if (e.code == "email-already-in-use") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Email Already is used",
                  style: TextStyle(fontSize: 18.0),
                )));
          }
        }
      }
    }
  }

  void sendOTPProvider(BuildContext context, UserViewModel userViewModel,
      {required String phonenumber}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (page1FormKey.currentState?.validate() ?? false) {
      // replace with actual verification with the phone in database
      userViewModel.setPhoneNumber(phonenumber);
      String? sentOTP;
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: 20),
        phoneNumber: /* userViewModel.phonenumber?.trim() */
            '+213770763430',
        verificationCompleted: (PhoneAuthCredential credential) {
          print('doooooooooooooooooooone');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
          print(e);
          print('failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          sentOTP = verificationId;
          print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
          print(verificationId);
          print('hhhhhhhhhhhhhhhhhhhhhhhhhhh');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      // API implementation (sending OTP) + errors managing
      // replace with actual sendig OTP process

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Page2ChangePassword(phonenumber: phonenumber, sentOTP: sentOTP!),
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
