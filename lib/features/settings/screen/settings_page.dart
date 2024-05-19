import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/features/settings/provider/settings_provider.dart';
import 'package:smart_farm/shared/widgets/app_navbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: SvgPicture.asset('assets/logos/AgriTech.svg'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const NavBar()));
          },
          icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Settings',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                settingsItem(
                  title: 'Weather',
                  value: settingsProvider.weatherNotifications,
                  onChanged: settingsProvider.setWeatherNotifications,
                  asset: Image.asset('assets/icons/settings/Spinach.png'),
                ),
                const SizedBox(height: 24),
                settingsItem(
                    title: 'Schedule',
                    value: settingsProvider.scheduleNotifications,
                    onChanged: settingsProvider.setScheduleNotifications,
                    asset: Image.asset('assets/icons/settings/Schedule.png')),
                const SizedBox(height: 24),
                settingsItem(
                  title: 'Government Support',
                  value: settingsProvider.governmentSupportNotifications,
                  asset: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SvgPicture.asset('assets/icons/settings/Gov.svg'),
                  ),
                  onChanged: settingsProvider.setGovernmentSupportNotifications,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget settingsItem({
    required String title,
    required Widget asset,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            asset,
            const SizedBox(
              width: 24,
            ),
            Text(title,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        Switch(
          activeColor: const Color.fromRGBO(52, 199, 89, 1),
          thumbColor: MaterialStateProperty.all(Colors.transparent),
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
