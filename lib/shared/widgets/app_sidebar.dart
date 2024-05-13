import 'package:flutter/material.dart';
import 'package:smart_farm/features/profile/screens/profile.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF0d986a)),
              accountName: const Text(
                "marcello",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              accountEmail: const Text(
                "marcello@marcello.com",
                style: TextStyle(
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
              title: const Text(
                "Profile",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ProfilePage()))
              },
            ),
            ListTile(
              leading:
                  Image.asset('assets/icons/SideBarIcons/SettingsIcon.png'),
              title: const Text(
                "Settings",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              onTap: () => {},
            ),
            ListTile(
              leading: Image.asset("assets/icons/SideBarIcons/ContactUs.png"),
              title: const Text(
                "Contact us",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              onTap: () => {},
            ),
            ListTile(
              leading: Image.asset("assets/icons/SideBarIcons/LogOut.png"),
              title: const Text(
                "Log out",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              onTap: () => {},
            )
          ],
        ));
  }
}
