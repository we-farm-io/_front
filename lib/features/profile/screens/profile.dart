import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_farm/features/profile/widgets/editprofilebutton.dart';

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
                  onPressed: () {},
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
                scale: 0.6,
                child: SizedBox(
                  width: mediaQuery.size.width / 2,
                  child: CustomButtonProfile(
                    buttonText: "Edit Profile",
                    onPressed: () {
                      // Add edit profile functionality here
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Farm's Stats",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Crops'),
                subtitle: const Text('Number of crops grown'),
                leading: const Icon(Icons.grass),
                onTap: () {
                  // Add functionality for crops
                },
              ),
              ListTile(
                title: const Text('Animals'),
                subtitle: const Text('Number of animals raised'),
                leading: const Icon(Icons.pets),
                onTap: () {
                  // Add functionality for animals
                },
              ),
              ListTile(
                title: const Text('Materials'),
                subtitle: const Text('Number of materials harvested'),
                leading: const Icon(Icons.storage),
                onTap: () {
                  // Add functionality for materials
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Colored Box Example',
//       home: Scaffold(
//         body: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 200, // Adjust the height as needed
//                 color: Colors.blue, // Set your desired color
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   top: 100), // Ensure content below the colored box
//               child: Center(
//                 child: Text(
//                   'Your Content Goes Here',
//                   style: TextStyle(fontSize: 24),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
