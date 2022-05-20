import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:outr/Components/textfieldcontainer.dart';
import '../API/dbapihandler.dart';
import '../Components/alertnoicon.dart';
import '../DataClasses/userdata.dart';
import 'mapviewpage.dart';
import 'registerviewpage.dart';
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
      appBar: AppBar(
        title: const Text('OutR'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      //Container that stretch to the whole screen that consists of backround image asset
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/backgroundloginpage.png'),
          fit: BoxFit.fill,
        )),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 20, 80, 0),
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
              padding: const EdgeInsets.fromLTRB(0, 155, 0, 0),
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
                                      builder: (context) => MapScreen(user: user, showPopUp: true)
                                  ),
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
              padding: const EdgeInsets.fromLTRB(90, 385, 90, 105),
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
                        "email",
                        "user_friends"
                      ]);

                      if (result.status == LoginStatus.success) {
                        final requestdata = await FacebookAuth.i.getUserData(
                          fields: "email, name, friends",
                        );
                        print(requestdata);
                        var userEmail;
                        var userName;
                        var friendsArray = [];
                        for (var k in requestdata.entries) {
                          if (k.key == 'email') {
                            userEmail = k.value;
                          }
                          if (k.key == 'name') {
                            userName = k.value;
                          }
                          if (k.key == 'friends') {
                            friendsArray == k.value;
                          }
                        }
                        print(friendsArray);
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
              padding: EdgeInsets.fromLTRB(60, 510, 40, 0),
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
