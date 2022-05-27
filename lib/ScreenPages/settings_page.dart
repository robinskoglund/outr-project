import 'package:provider/provider.dart';

import '../Components/change_theme_button.dart';
import '../Components/navigation_bar.dart';
import '../Components/theme_provider.dart';
import '../DataClasses/userdata.dart';
import '../ScreenPages/saved_routes_page.dart';
import '../ScreenPages/mapview_page.dart';
import '../ScreenPages/login_view_page.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  final User user;
  SettingsPage(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(

        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
          //ändrar färgen på burgarmeny
          title: const Text('Settings'),
          titleTextStyle: TextStyle(
              fontSize: 44,
              color: Colors.black),
          backgroundColor: Colors.white,
        ),
        endDrawer: OutrNavigationBar(user),
        body: buildBasicListView(context),
        );
      }



  Widget buildBasicListView(BuildContext context) => ListView(

    children: [
      ListTile(
        title: Text("Account",
            style: TextStyle( fontSize: 30)),
        subtitle: Text("Logged in as " + user.email,
            style: TextStyle( fontSize: 20)),
        trailing: Icon(Icons.arrow_forward, color: Colors.black),

        onTap: () => Navigator.pop(context),


      ),
      SizedBox(height: 5),
      Divider(color: Colors.black),
      SizedBox(height: 5),

      ListTile(
        title: Text("Notifications",
            style: TextStyle( fontSize: 30)),
        subtitle: Text("Manage your Notifications",
            style: TextStyle( fontSize: 20)),
        trailing: Icon(Icons.arrow_forward, color: Colors.black),

        onTap: () => Navigator.pop(context),


      ),
      SizedBox(height: 5),
      Divider(color: Colors.black),
      SizedBox(height: 5),

      ListTile(
        title: Text("Application language",
            style: TextStyle( fontSize: 30)),
        subtitle: Text("Manage your language settings",
            style: TextStyle( fontSize: 20)),
        trailing: Icon(Icons.arrow_forward, color: Colors.black),

        onTap: () => Navigator.pop(context),


      ),
      SizedBox(height: 5),
      Divider(color: Colors.black),
      SizedBox(height: 5),

      ListTile(
        title: Text("Terms and Conditions",
            style: TextStyle( fontSize: 30)),
        subtitle: Text("Read the Terms and Conditions",
            style: TextStyle( fontSize: 20)),
        trailing: Icon(Icons.arrow_forward, color: Colors.black),

        onTap: () => Navigator.pop(context),

      ),

      SizedBox(height: 5),
      Divider(color: Colors.black),
      SizedBox(height: 5),

      ListTile(
        title: Text("About",
            style: TextStyle( fontSize: 30)),
        subtitle: Text("About OutR",
            style: TextStyle( fontSize: 20)),
        trailing: Icon(Icons.arrow_forward, color: Colors.black),

        onTap: () => Navigator.pop(context),

      ),
      SizedBox(height: 5),
      Divider(color: Colors.black),
      SizedBox(height: 5),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
          Flexible(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  )
              ),
              child: const Text("Log Out", style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.normal,
                  color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    ],
  );
}


