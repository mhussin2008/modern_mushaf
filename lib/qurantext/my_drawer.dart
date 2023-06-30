import 'package:flutter/material.dart';
import 'settings.dart';
import 'package:share_plus/share_plus.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/splashicon.png",
                  height: 80.0,
                ),
               const SizedBox(height: 10,),
                const Text(
                  "القرآن الكريم",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              "Settings",
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text(
              "Share App",
            ),
            onTap: () {
            // Share.share(
            //
            // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text(
              "Rate App",
            ),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SettingsScreen(),
              //   ),
              //
            },
          ),
        ],
      ),
    );
  }
}
