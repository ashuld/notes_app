import 'package:flutter/material.dart';
import 'package:notes_app/component/drawer_tile.dart';
import 'package:notes_app/screen/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //header
          const DrawerHeader(
              child: Icon(
            Icons.book,
            size: 50,
          )),
          //notes
          DrawerTile(
              onTap: () => Navigator.of(context).pop(),
              title: "Notes",
              leading: const Icon(Icons.home)),
          //settings
          DrawerTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              },
              title: "Settings",
              leading: const Icon(Icons.settings)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text('Version',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.inversePrimary)),
          )
        ],
      ),
    );
  }
}
