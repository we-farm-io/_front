import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/drawer.dart';
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
      home: ChangeNotifierProvider<BottomNavigationBarProvider>(
        child: const NavBar(),
        create: (BuildContext context) => BottomNavigationBarProvider(),
      ),
    );
    // ChangeNotifierProvider<BottomNavigationBarProvider>(
    //   child: const NavBar(),
    //   create: (BuildContext context) => BottomNavigationBarProvider(),
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
