// to implement reset password via mail go from line 153 :)

// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? phonenumber;
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

  void setSignUpCredentials(
      String email, String password, String id, String phonenumber) {
    this.email = email;
    this.password = password;
    this.id = id;
    this.phonenumber = phonenumber;
    errorMessage = null;
    notifyListeners();
  }

  void setPhoneNumber(String phonenumber) {
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
      print(e.code);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "invalid credentials",
              style: TextStyle(fontSize: 18.0),
            )));
      }
      return null;
    }
  }

  void signUpProvider(BuildContext context, UserViewModel userViewModel,
      {required String phonenumber,
      required String email,
      required String password,
      required String id}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    userViewModel.setSignUpCredentials(email, password, id, phonenumber);
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
        if (usercredential.user != null) {
          print("entered here");
          String userId = usercredential.user!.uid;
          print("user id $userId");
          final usersCollection =
              FirebaseFirestore.instance.collection('users');
          await usersCollection.doc(userId).set({
            'email': email,
            "phoneNumber": phonenumber,
            'createdAt': FieldValue.serverTimestamp(),
            "agriculture_id": id,
          });
          print("routing success");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessAuth()),
          );
        } else {
          print("id null");
        }

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
          print(e.code);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Email Already is used",
                style: TextStyle(fontSize: 18.0),
              )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                e.code,
                style: const TextStyle(fontSize: 18.0),
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
    return true;
  }

  Future<void> sendPasswordResetEmail(
      BuildContext context, String _email) async {
    // send password reset email here -----------------------------
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: _email)
        .get();
    if (query.docs.isNotEmpty) {
      // Email is already used... }

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 80, 255, 64),
            content: Text(
              "we sent you a recovery email ",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
        // If the email exists, Firebase will send a password reset email
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-email") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 64, 64),
              content: Text(
                "invalid email ",
                style: TextStyle(
                    fontSize: 18.0, color: Color.fromARGB(255, 235, 232, 232)),
              )));
        } else {
          // Handle other errors
          print(e.code);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 64, 64),
          content: Text(
            "Please verify your email ",
            style: TextStyle(
                fontSize: 18.0, color: Color.fromARGB(255, 235, 232, 232)),
          )));
    }
  }
  // -------------------------------------------------------------

  bool linkChecked() {
    // Replace with actual verification
    return true;
  }

  Future<void> changePasswordProvider(
      BuildContext context, UserViewModel userViewModel,
      {required String currentPassword, required String newPassword}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    //if (page2FormKey.currentState!.validate()) {

    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Re-authenticate the user with their current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update the user's password
      await user.updatePassword(newPassword);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessChangePassword(),
        ),
      );
      print('Password changed successfully!');
    } on FirebaseAuthException catch (e) {
      // Handle errors
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 255, 64, 64),
            content: Text(
              "invalid current password ",
              style: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 235, 232, 232)),
            )));
        print('Error: Wrong password');
      } else if (e.code == 'weak-password') {
        print('Error: Weak password');
      } else {
        print('Error: ${e.code} - ${e.message}');
      } // + modify in database

      // }
    }
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
