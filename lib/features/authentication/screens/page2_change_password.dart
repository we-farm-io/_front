import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/shared/utils/palette.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';

class Page2ChangePassword extends StatefulWidget {
  final String phonenumber;
  final String sentOTP;

  const Page2ChangePassword({
    super.key,
    required this.phonenumber,
    required this.sentOTP,
  });

  @override
  State<Page2ChangePassword> createState() => _Page2ChangePasswordState();
}

class _Page2ChangePasswordState extends State<Page2ChangePassword> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return Consumer<UserViewModel>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset(
                    'assets/images/authentication_images/changepass2.svg'),
                const SizedBox(
                  height: 10,
                ),
                SvgPicture.asset('assets/logos/AgriTech.svg'),
                const Text(
                  'Change Password',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'We sent you a code to verify your phone number\nsent to ${widget.phonenumber}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SquareInput(controller: c1, first: true, last: false),
                    SquareInput(controller: c2, first: false, last: false),
                    SquareInput(controller: c3, first: false, last: false),
                    SquareInput(controller: c4, first: false, last: true),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'didn’t receive a code? ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(175, 175, 175, 1),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Resend',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Palette.buttonGreen),
                          )),
                      onTap: () {
                        userViewModel.sendOTPProvider(
                          context,
                          userViewModel,
                          phonenumber: widget.phonenumber,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    buttonText: 'Verify',
                    onPressed: () {
                      if (c1.text.isEmpty ||
                          c2.text.isEmpty ||
                          c3.text.isEmpty ||
                          c4.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all 4 fields'),
                          ),
                        );
                      } else {
                        String enteredOTP =
                            c1.text + c2.text + c3.text + c4.text;
                        userViewModel.verifyOTP(
                          context,
                          userViewModel,
                          phonenumber: widget.phonenumber,
                          sentOTP: widget.sentOTP,
                          enteredOTP: enteredOTP,
                        );
                      }
                    }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SquareInput extends StatelessWidget {
  TextEditingController controller;
  bool first;
  bool last;
  SquareInput({
    required this.controller,
    required this.first,
    required this.last,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 1.5)),
        child: TextField(
          controller: controller,
          onChanged: ((value) {
            if (value.isNotEmpty && !last) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && !first) {
              FocusScope.of(context).previousFocus();
            }
          }),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          style: const TextStyle(fontSize: 21),
          decoration: InputDecoration(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).width / 2,
                  maxWidth: MediaQuery.sizeOf(context).width / 6)),
        ));
  }
}
