import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:outr/Components/text_field_container.dart';
import '../API/dbapihandler.dart';
import '../Components/alert_no_icon.dart';
import '../DataClasses/userdata.dart';
import 'mapview_page.dart';
import 'register_view_page.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController mailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //Container that stretch to the whole screen that consists of backround image asset
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffDCEEE3), Color(0xffA4EEC1), Color(0xff1E7440), Color(0xffDCEEE3)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.4, 0.6, 0.9],
              tileMode: TileMode.clamp),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 365, 80, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextContainer(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                      controller: mailInput,
                    ),
                  ),
                  TextContainer(
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                      controller: passwordInput,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 495, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text.rich(
                    //Profil knappen
                    TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              bool check = await checkPassword(
                                  mailInput.text.toLowerCase(),
                                  passwordInput.text);

                              print(mailInput.text);
                              print(passwordInput.text);

                              if (check == true) {
                                updateLogin(mailInput.text.toLowerCase());
                                User user = await getUser(mailInput.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen(
                                          user: user, showPopUp: true)),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertNoIcon(
                                          'Alert',
                                          'Wrong email or password!',
                                          'Cancel',
                                          'Abort');
                                    });
                                mailInput.clear();
                                passwordInput.clear();
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    //Profil knappen
                    TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                      ),
                      children: [
                        TextSpan(
                          text: 'Register ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 30, 90, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/logo.png"),
                widthFactor: 118,
                heightFactor: 118,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(110, 530, 110, 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SignInButtonBuilder(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    text: 'login with facebook',
                    icon: Icons.facebook,
                    onPressed: () async {
                      final result = await FacebookAuth.i.login(permissions: [
                        "public_profile",
                        "email"
                      ]);

                      if (result.status == LoginStatus.success) {
                        final requestdata = await FacebookAuth.i.getUserData(
                          fields: "email, name",
                        );
                        print(requestdata);
                        var userEmail;
                        var userName;
                        for (var k in requestdata.entries) {
                          if (k.key == 'email') {
                            userEmail = k.value;
                          }
                          if (k.key == 'name') {
                            userName = k.value;
                          }
                        }
                        //GET-call
                        User user = await getUser(userEmail);
                        print(user);
                        if (user.email.isEmpty) {
                          addUser(userName, userEmail);
                          user = await getUser(userEmail);
                        } else {
                          updateLogin(userEmail);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapScreen(user: user, showPopUp: true)),
                        );
                      }
                    },
                    backgroundColor: Colors.blue[900]!,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 250, 40, 0),
              child: Container(
                height: 90,
                width: 290,
                child: Stack(
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text('Start your journey',
                          style: TextStyle(
                              fontFamily: "Dongle",
                              fontSize: 43,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text('to a healthier lifestyle',
                          style: TextStyle(
                              fontFamily: "Dongle",
                              fontSize: 43,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
