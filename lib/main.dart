import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/drawer.dart';
import 'package:smart_farm/onboarding.dart';
//import 'package:smart_farm/onboarding.dart';
import 'package:smart_farm/views/agro_insight.dart';
import 'package:smart_farm/views/home_page.dart';
import 'package:smart_farm/views/plant_doc.dart';
import 'package:smart_farm/views/store.dart';
import 'package:smart_farm/views/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_farm/widgets/nav_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriTech',
      home: FutureBuilder(
        future:
            SharedPreferences.getInstance(), // Get SharedPreferences instance
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for SharedPreferences to be initialized
            return const CircularProgressIndicator();
          } else {
            // Check if the onboarding has been completed before
            bool onboardingCompleted = false;
            // snapshot.data?.getBool('onboardingCompleted') ?? false;

            // Decide whether to show onboarding or directly launch homepage
            return onboardingCompleted
                ? const NavNotifier()
                : const OnBoarding(); // onboarding is disabled for now
          }
        },
      ),
    );
  }
}

class NavNotifier extends StatelessWidget {
  const NavNotifier({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarProvider>(
      child: const NavBar(),
      create: (BuildContext context) => BottomNavigationBarProvider(),
    );
  }
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
