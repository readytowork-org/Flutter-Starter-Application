import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/login_image.jpg')),
                  accountEmail: Text('pratik.adhikari@readytowork.jp'),
                  accountName: Text('Pratik Adhikari'),
                )),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.red,
            ),
            Divider(
              thickness: 1,
              color: Colors.white,
            ),
            // SizedBox(height: 10),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.red,
            ),
            Divider(
              thickness: 1,
              color: Colors.white,
            ),
            // SizedBox(height: 10),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 24.0,
              ),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
