import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/features/home/providers/news_provider.dart';
import 'package:smart_farm/features/store/screens/store.dart';
import 'package:smart_farm/shared/services/notifications/notifications_services.dart';
import 'package:smart_farm/shared/widgets/app_sidebar.dart';
import 'package:smart_farm/features/agroinsight/screens/agro_insight.dart';
import 'package:smart_farm/features/home/screens/home_screen.dart';
import 'package:smart_farm/features/plantdoc/screens/plant_doc.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/weather/screens/weather.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
  // _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var currentTab = [
    const HomePage(),
    const PlantDoc(),
    const AgroInsight(),
    const StorePage(),
    const WeatherPage(),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewsProvider>(context, listen: false).getNews(context);
    });
    NotificationsServices().requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    const Color iconActive = Color.fromARGB(255, 51, 203, 89);
    const Color iconInActive = Color.fromARGB(255, 0, 0, 0);

    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const SideBar(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/side_bar.svg',
                    matchTextDirection: true,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            centerTitle: true,
            title: const Wrap(
              textDirection: TextDirection.ltr,
              direction: Axis.horizontal,
              children: [
                Text("Agri",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color(0xFF98C13F),
                      fontSize: 24,
                    )),
                Text(
                  "Tech",
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Color(0xFF159148),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => {},
                icon: SvgPicture.asset(
                  'assets/icons/notification_active.svg',
                  width: 20,
                  height: 28,
                ),
              ),
            ],
          ),
        ),
        body: currentTab[provider.currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, -3),
                )
              ]),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            indicatorColor: Colors.transparent,
            labelBehavior: null,
            height: 60,
            elevation: 0,

            // indicatorColor: Colors.green,
            selectedIndex: provider.currentIndex,
            onDestinationSelected: (index) {
              provider.currentIndex = index;
            },
            destinations: [
              NavigationDestination(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    'assets/icons/home_inactive.svg',
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        provider.currentIndex == 0 ? iconActive : iconInActive,
                        BlendMode.srcIn),
                  ),
                ),
                label: '',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    'assets/icons/plant_care_inactive.svg',
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        provider.currentIndex == 1 ? iconActive : iconInActive,
                        BlendMode.srcIn),
                  ),
                ),
                label: '',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    'assets/icons/crop_prediction.svg',
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        provider.currentIndex == 2
                            ? iconActive
                            : const Color(0xFFF0D64D),
                        BlendMode.srcIn),
                  ),
                ),
                label: '',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    'assets/icons/store_inactive.svg',
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        provider.currentIndex == 3 ? iconActive : iconInActive,
                        BlendMode.srcIn),
                  ),
                ),
                label: '',
                tooltip: '',
              ),
              NavigationDestination(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    'assets/icons/weather_inactive.svg',
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                        provider.currentIndex == 4 ? iconActive : iconInActive,
                        BlendMode.srcIn),
                  ),
                ),
                label: '',
                tooltip: '',
              ),
            ],
          ),
        ));
  }
}
