import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:outr/Components/outr_icon_icons.dart';
import 'package:outr/ScreenPages/settings_page.dart';
import '../DataClasses/userdata.dart';
import '../ScreenPages/achievements_page.dart';
import '../ScreenPages/login_view_page.dart';
import '../ScreenPages/mapview_page.dart';
import '../ScreenPages/profile_page_view.dart';
import '../ScreenPages/saved_routes_page.dart';
import 'outr_icon_icons.dart';

final Color backgroundColor = Color(0xFF353535);
late double screenWidth, screenHeight;

class OutrNavigationBar extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final User user;

  OutrNavigationBar(this.user, {Key? key}) : super(key: key);


  //Detta är själva "hamburgarmeny" navigation baren som används på många av pages i appen
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //mediaquery, screenHeight
    // & screenWidth anpassar storleken dynamiskt
    screenHeight = size.height;
    screenWidth = size.width;

    return Drawer(
      child: Material(
        color: backgroundColor,
        child: ListView(
          children: <Widget>[
            Container(
              //   color: backgroundColor,
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'OutR',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Profile',
                    icon: Icons.account_circle,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Saved routes',
                    icon: Icons.star,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.black),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final hoverColor = Colors.grey;

    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: TextStyle(fontFamily: "Dongle", fontSize: 24, color: Colors.white)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MapScreen(user: user, showPopUp: false),
        ));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileScreen(user),
        ));
        break;

      case 2:
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SavedRoutesPage(user),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingsPage(user),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Home(),
        ));
        break;
    }
  }
}