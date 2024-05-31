// to implement reset password via mail go from line 153 :)

// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm/features/authentication/models/user.dart';
import 'package:smart_farm/features/authentication/screens/login_page.dart';
import 'package:smart_farm/features/authentication/screens/success_auth.dart';
import 'package:smart_farm/features/authentication/screens/success_change_password.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';

class UserViewModel with ChangeNotifier {
  // final loginFormKey = GlobalKey<FormState>();
  // final signUpFormKey = GlobalKey<FormState>();
  // final page1FormKey = GlobalKey<FormState>();
  // final page2FormKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? id;
  String? errorMessage;
  // ignore: unused_element
  Userclass? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Userclass(uid: user.uid) : null;
  }

  void setLoginCredentials(String email, String password) {
    this.email = email;
    this.password = password;
    errorMessage = null;
    notifyListeners();
  }

  void setSignUpCredentials(String email, String password, String id) {
    this.email = email;
    this.password = password;
    this.id = id;
    errorMessage = null;
    notifyListeners();
  }

  void setPhoneNumber(String phonenumber) {
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

  Future<UserCredential?> loginProvider(
    BuildContext context,
    UserViewModel userViewModel, {
    required String email,
    required String password,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    //if (loginFormKey.currentState?.validate() ?? false) {
      // replace with actual verification
      // API implementation + errors managing
      userViewModel.setLoginCredentials(email, password);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
        return credential;
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
        return null;
      }
    //} else if (email.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email or pasword is incorrect'),
        ),
      );
    //}
  }

  void signUpProvider(BuildContext context, UserViewModel userViewModel,
      {required String email,
      required String password,
      required String id}) async {
    FocusManager.instance.primaryFocus?.unfocus();

   // if (signUpFormKey.currentState?.validate() ?? false) {
      // replace with actual verification
      // API implementation + errors managing

      userViewModel.setSignUpCredentials(email, password, id);
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
              .createUserWithEmailAndPassword(email: email, password: password);
          // ignore: unused_local_variable
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
   // }
  }

  bool isValidEmail(String email) {
    // Replace with actual email verification
    final emailValide = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailValide.hasMatch(email);
  }

  bool oldPasswordCorrect(String uid, String enteredPassword) {
    //replace with actual verification
    return enteredPassword == '123';
  }

  void sendPasswordResetEmail(BuildContext context, String email) {
    // send password reset email here -----------------------------
    try {
      // send mail
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send password reset email: $e'),
        ),
      );
    }
  }
  // -------------------------------------------------------------

  bool linkChecked() {
    // Replace with actual verification
    return true;
  }

  void changePasswordProvider(BuildContext context, UserViewModel userViewModel,
      {required String newpassword}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    //if (page2FormKey.currentState!.validate()) {
    userViewModel.setPassword(newpassword); // + modify in database
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SuccessChangePassword(),
      ),
    );
    // }
  }

  Future<void> signOut(
    BuildContext context,
    UserViewModel userViewModel,
  ) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) =>
              const LoginPage()), // Navigate to your login page
      (Route<dynamic> route) => false, // Clear all existing routes
    );
  }
}

class AuthState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  AuthState() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners(); // Notify listeners when user state changes
    });
  }
}
