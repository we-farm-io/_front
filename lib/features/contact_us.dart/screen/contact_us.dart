import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/contact_us.dart/provider/report_provider.dart';
import 'package:smart_farm/features/contact_us.dart/widgets/send_button.dart';
import 'package:smart_farm/features/contact_us.dart/widgets/input.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUs extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportProvider>(builder: (context, reportProvider, child) {
      return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(
            AppLocalizations.of(context)!.contactUs,
            style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NavBar()));
            },
            icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Input(
                              hintText: AppLocalizations.of(context)!.firstName,
                              controller: firstNameController)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Input(
                              hintText: AppLocalizations.of(context)!.lastName,
                              controller: lastNameController)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Input(hintText: AppLocalizations.of(context)!.email, controller: emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  Input(hintText: AppLocalizations.of(context)!.phoneNumber, controller: phoneController),
                  const SizedBox(
                    height: 20,
                  ),
                  Input(
                    hintText: AppLocalizations.of(context)!.yourMessage,
                    controller: messageController,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                  ),
                  SendButton(
                      buttonText: AppLocalizations.of(context)!.sendMessage,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          reportProvider.createReport(
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              email: emailController.text.trim(),
                              phoneNumber: phoneController.text.trim(),
                              message: messageController.text.trim());
                          _showSuccessDialog(context);
                        }
                      }),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SvgPicture.asset('assets/icons/Vector_Done.svg'),
          content: Text(
            AppLocalizations.of(context)!.messageSentSuccessfully,
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const NavBar()),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.ok,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromRGBO(52, 199, 89, 1)),
              ),
            ),
          ],
        );
      },
    );
  }
}