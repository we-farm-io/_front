import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/contact_us.dart/screen/contact_us.dart';
import 'package:smart_farm/features/profile/screens/profile.dart';
import 'package:smart_farm/features/settings/screen/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    // ignore: no_leading_underscores_for_local_identifiers
    final FirebaseAuth __auth = FirebaseAuth.instance;
    final currentUser = __auth.currentUser;
    String getUsernameFromEmail(String? email) {
      if (email != null) {
        final parts = email.split('@');
        return parts[0];
      }
      return "";
    }

    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF0d986a)),
              accountName: Text(
                (currentUser != null
                    ? getUsernameFromEmail(currentUser.email)
                    : 'marcello'),
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              accountEmail: Text(
                ('${currentUser != null ? currentUser.email : 'marcello@gmail.com'}'),
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset('assets/images/palestine.png',
                      fit: BoxFit.cover),
                ),
              ),
            ),
            ListTile(
              leading: Image.asset("assets/icons/SideBarIcons/ProfileIcon.png"),
              title: Text(
                AppLocalizations.of(context)!.sidebarUserProfile,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage()))
              },
            ),
            ListTile(
              leading:
                  Image.asset('assets/icons/SideBarIcons/SettingsIcon.png'),
              title:  Text(
                AppLocalizations.of(context)!.sidebarSettings,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage()))
              },
            ),
            ListTile(
              leading: Image.asset("assets/icons/SideBarIcons/ContactUs.png"),
              title: Text(
                AppLocalizations.of(context)!.sidebarContactUs,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              onTap: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ContactUs()))
              },
            ),
            ListTile(
              leading: Image.asset("assets/icons/SideBarIcons/LogOut.png"),
              title:  Text(
                AppLocalizations.of(context)!.sidebarLogOut,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              onTap: () => {
                context.read<UserViewModel>().signOut(context, userViewModel)
              },
            )
          ],
        ));
  }
}
