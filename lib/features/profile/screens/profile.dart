import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_farm/features/profile/screens/animals_page.dart';
import 'package:smart_farm/features/profile/screens/change_password_page.dart';
import 'package:smart_farm/features/profile/screens/crops_page.dart';
import 'package:smart_farm/features/profile/screens/edit_profile.dart';
import 'package:smart_farm/features/profile/screens/materials_page.dart';
import 'package:smart_farm/features/profile/screens/statistics_page.dart';
import 'package:smart_farm/features/profile/widgets/editprofilebutton.dart';
import 'package:smart_farm/features/store/screens/my_products.dart';
import 'package:smart_farm/features/to_do_list/screens/to_do_list_page.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
                color: const Color(0xFF0D986A),
                height: mediaQuery.size.height / 4)),
        Positioned(
            top: 50,
            left: 10,
            child: Transform.scale(
                scaleX: 1.3,
                child: IconButton(
                  icon: SvgPicture.asset("assets/icons/arrow-left.svg"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NavBar()));
                  },
                ))),
        Positioned(
          top: mediaQuery.size.height / 10,
          right: 0,
          left: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 69,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset('assets/images/palestine.png'),
                ),
              ),
              Transform.scale(
                scale: 0.65,
                child: SizedBox(
                  width: mediaQuery.size.width / 2,
                  child: CustomButtonProfile(
                    buttonText: "Edit Profile",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const EditProfilePage()));

                      // Add edit profile functionality here
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
             Column(
                  children: [
                    Container(
                      color: const Color(0xFFF6F6F6),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width / 10,
                          vertical: 5,
                        ),
                        child: const Text(
                          "Farm's Stats",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Crops',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CropsPage()));
                        // Add functionality for crops
                      },
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Animals',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AnimalsPage()));
                        // Add functionality for animals
                      },
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Materials',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MaterialsPage()));
                        // Add functionality for materials
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: const Color(0xFFF6F6F6),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width / 10,
                          vertical: 5,
                        ),
                        child: const Text(
                          "Content",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'My to do list',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ToDoListPage()));
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: const Color(0xFFF6F6F6),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width / 10,
                          vertical: 5,
                        ),
                        child: const Text(
                          "Store",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'My products',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyProducts()));
                      },
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'My statistics',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const StatisticsPage()));
                        // Add functionality for crops
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: const Color(0xFFF6F6F6),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width / 10,
                          vertical: 5,
                        ),
                        child: const Text(
                          " ",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      title: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Change password',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "assets/icons/right_arrow.svg",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangePasswordProfile()));
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
        Positioned(
          top: mediaQuery.size.height / 14,
          right: 0,
          left: 0,
          child: Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }
}
