import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/onboarding/screens/onboarding_screen.dart';
import 'package:smart_farm/shared/services/shared_preferences_service.dart';
import 'package:smart_farm/shared/widgets/nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesService.init();
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
        home: FutureBuilder<bool>(
          future: SharedPreferencesService.onboardingCompleted,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final bool onboardingCompleted = snapshot.data ?? false;
              return onboardingCompleted
                  ? const NavBar()
                  : const Onboarding(); //boarding is disabled for now
            }
          },
        ),
      ),
    );
  }
}
