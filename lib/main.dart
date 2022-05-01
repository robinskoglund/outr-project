import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:outr/geopositionpage.dart';
import 'mapviewpage.dart';

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