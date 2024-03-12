import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 4, 185, 10)),
          accountName: const Text("marcello"),
          accountEmail: const Text("marcello@marcello.com"),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child:
                  Image.asset('assets/images/palestine.png', fit: BoxFit.cover),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("settings"),
          onTap: () => {},
        )
      ],
    ));
  }
}
