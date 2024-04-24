import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_farm/features/authentication/models.authentication/authentication_models.dart';
import 'package:smart_farm/features/authentication/screens/auth.screens/sign_up.dart';
import 'package:smart_farm/onboarding.dart';
import 'package:smart_farm/widgets/nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyCOgNGfXwwQzn1AqmCOwBJMaFJcLLlVsIc", // paste your api key here
      appId:
          "1:1079163628132:android:a65af8797b83eabaad0d71", //paste your app id here
      messagingSenderId: "1079163628132", //paste your messagingSenderId here
      projectId: "farmai-e033e", //paste your project id here
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
      ],
      child: MaterialApp(
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
              bool onboardingCompleted = true;
              // snapshot.data?.getBool('onboardingCompleted') ?? false;

              // Decide whether to show onboarding or directly launch homepage
              return onboardingCompleted
                  ? const OnBoarding()
                  // ignore: dead_code
                  : const OnBoarding(); // onboarding is disabled for now
            }
          },
        ),
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
