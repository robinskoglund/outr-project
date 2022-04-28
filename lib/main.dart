import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 250.0, horizontal: 135.0),
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
                Buttons.LinkedIn,
                text: "login with linkedin",
                onPressed: () {},
              ),
              SignInButtonBuilder(
                text: 'map tester',
                icon: Icons.map_sharp,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                },
                backgroundColor: Colors.green,
              ),
            ]
          ),
        ),
      ),
    );
  }
}