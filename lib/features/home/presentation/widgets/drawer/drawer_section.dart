import 'package:flutter/material.dart';
import 'package:planza/core/widgets/buttons/profile_button.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileButton(
                      radius: 25,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(Icons.dark_mode_rounded),
                      ),
                    ),
                  ],
                ),
                Text('Amir Hosein Zamani'),
                /* CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.JPEG'),
                    radius: 20,
                  ), */
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My Profile'),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Theme'),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.dark_mode_rounded,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Settings'),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.settings_rounded,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
