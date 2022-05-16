import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:outr/Components/outr_icon_icons.dart';
import 'outr_icon_icons.dart';

final Color backgroundColor = Color(0xFF353535);
late double screenWidth, screenHeight;

class OutrNavigationBar extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);


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
                    text: 'History',
                    icon: Icons.history,
                    onClicked: () => selectedItem(context, 2),
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

    /* här görs själva switchen till sidorna
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PeoplePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavouritesPage(),
        ));
        break;
    }
  */
  }

}