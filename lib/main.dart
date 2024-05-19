import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/authentication/models/authentication_models.dart';
import 'package:smart_farm/features/contact_us.dart/provider/report_provider.dart';
import 'package:smart_farm/features/home/providers/news_provider.dart';
import 'package:smart_farm/features/onboarding/screens/onboarding_screen.dart';
import 'package:smart_farm/features/plantdoc/providers/plantgrowth_provider.dart';
import 'package:smart_farm/features/settings/provider/settings_provider.dart';
import 'package:smart_farm/features/store/providers/products_provider.dart';
import 'package:smart_farm/features/to_do_list/providers/tasks_provider.dart';
import 'package:smart_farm/features/weather/providers/weather_provider.dart';
import 'package:smart_farm/shared/services/notifications/notifications_controller.dart';
import 'package:smart_farm/shared/services/notifications/notifications_services.dart';
import 'package:smart_farm/shared/services/shared_preferences_service.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';

Future main() async {
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
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  await SharedPreferencesService.init();
  // await AwesomeNotifications().initialize(
  //     null,
  //     [
  //       NotificationChannel(
  //         channelGroupKey: "group",
  //         channelKey: "basic_channel",
  //         channelName: "Notification",
  //         channelDescription: "description",
  //       )
  //     ],
  //     channelGroups: [
  //       NotificationChannelGroup(
  //           channelGroupKey: "channelGroupKey",
  //           channelGroupName: "channelGroupName")
  //     ],
  //     debug: true);

  // bool isAllowedToSendNotification =
  //     await AwesomeNotifications().isNotificationAllowed();
  // if (!isAllowedToSendNotification) {
  //   AwesomeNotifications().requestPermissionToSendNotifications();
  // }

  NotificationsServices().initializeNotifications();

  runApp(const MyApp());
}

class InAppWebViewController {
  static setWebContentsDebuggingEnabled(bool kDebugMode) {}
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TasksProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReportProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AgriTech',
        home: 
        FutureBuilder<bool>(
          future: SharedPreferencesService.onboardingCompleted,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              final bool onboardingCompleted = snapshot.data ?? false;
              // ignore: avoid_print
              print(snapshot.data);
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
