import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:outr/geopositionpage.dart';
import 'mapviewpage.dart';
import 'geopositionpage.dart';

void main() => runApp(MaterialApp(
  home: Home()
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outr Demo'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),

      //Container that stretch to the whole screen that consists of backround image asset
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/greenbackgroundtest.jpg'),
            fit: BoxFit.cover,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 200.0, horizontal: 110.0),

          //vertical column that includes all buttons on startpage
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SignInButtonBuilder(
                text: 'login with facebook',
                icon: Icons.facebook,
                onPressed: () {},
                backgroundColor: Colors.blue[900]!,
              ),
              SignInButton(
                Buttons.Apple,
                text: "login with apple",
                onPressed: () {},
              ),
              SignInButtonBuilder(
                text: 'map tester',
                icon: Icons.map_sharp,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  );
                },
                backgroundColor: Colors.green,
              ),

              //onPressed {...} is where we assign what happens when button is clicked.
              SignInButtonBuilder(
                text: 'get coords',
                icon: Icons.maps_ugc,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GeoLocationScreen()),
                  );
                },
                backgroundColor: Colors.redAccent,
              ),
            ]
          ),
        ),
      ),
    );
  }
}