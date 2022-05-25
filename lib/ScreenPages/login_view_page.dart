import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:outr/Components/text_field_container.dart';
import 'package:outr/Components/theme_provider.dart';
import '../API/dbapihandler.dart';
import '../Components/alert_no_icon.dart';
import '../DataClasses/userdata.dart';
import 'mapview_page.dart';
import 'register_view_page.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() => runApp(MaterialApp(
  /* theme: ThemeData(
  fontFamily: "Dongle",
  ), Används för att skapa ett tema för hela appen med font, men blir fucked med
  fonts o storlekarna
    */
    home: Home()));

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
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff61A4FF), const Color(0xffD8EEFF)],
              begin:  FractionalOffset(0.0, 0.0),
              end:  FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.fromLTRB(70, 365, 80, 0),
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
              padding:  EdgeInsets.fromLTRB(0, 520, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text.rich(
                    //Profil knappen
                    TextSpan(
                      style:  TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
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
                      style:  TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
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
              padding:  EdgeInsets.fromLTRB(90, 50, 90, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/logo.png"),
                widthFactor: 118,
                heightFactor: 118,
              ),
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(110, 530, 110, 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SignInButtonBuilder(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    text: 'Sign in with Facebook', fontSize: 14,
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
                      padding: EdgeInsets.only(left: 25, top: 20),
                      child: Text('Start your journey',
                          style: TextStyle(
                              fontFamily: "Dongle",
                              fontSize: 43,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
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
