import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:outr/Components/emailfield.dart';
import '../API/dbapihandler.dart';
import 'mapviewpage.dart';
import 'registerviewpage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../Components/navigationbar.dart';
import '../Components/passwordfield.dart';

void main() => runApp(MaterialApp(
    home: Home()
));

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
            image: DecorationImage(
              image: AssetImage('assets/backgroundloginpage.png'),
              fit: BoxFit.fill,
            )
        ),
        child: Stack(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(70, 30, 80, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    EmailField(mailInput),
                    PasswordField(passwordInput),
                  ],
                ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 155, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text.rich( //Profil knappen
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

                              bool check = await checkPassword(mailInput.text.toLowerCase(), passwordInput.text);
                              if(check == true){
                                //Ta sig till din sida
                                updateLogin(mailInput.text);
                              } else{
                                //Visa en felmeddelande
                              }
                              print(mailInput.text);
                              print(passwordInput.text);
                              mailInput.clear();
                              passwordInput.clear();
                            },
                        ),
                      ],
                    ),
                  ),
                  Text.rich( //Profil knappen
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
                                MaterialPageRoute(builder: (context) => RegisterScreen()),
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
              padding: const EdgeInsets.fromLTRB(90, 445, 90, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SignInButtonBuilder(
                    text: 'login with facebook',
                    icon: Icons.facebook,
                    onPressed: () async {
                      final result = await FacebookAuth.i.login(
                          permissions: ["public_profile", "email", "user_friends"]
                      );

                      if(result.status == LoginStatus.success){
                        final requestdata = await FacebookAuth.i.getUserData(
                          fields: "email, name, friends",
                        );
                        print(requestdata);
                        var userEmail;
                        var userName;
                        var friendsArray = [];
                        for(var k in requestdata.entries){
                          if(k.key == 'email'){
                            userEmail = k.value;
                          } if (k.key == 'name'){
                            userName = k.value;
                          } if(k.key == 'friends'){
                            friendsArray == k.value;
                          }
                        }
                        print(friendsArray);
                        //GET-call
                        User user = await getUser(userEmail);
                        print(user);
                        if(user.email.isEmpty){
                          addUser(userName, userEmail);
                        }else{
                          updateLogin(userEmail);
                        }
                      }
                    },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

                    onPressed: () async {

                      bool check = await checkPassword(mailInput.text.toLowerCase(), passwordInput.text);
                      if(check == true){
                        //Ta sig till din sida
                        updateLogin(mailInput.text);
                      } else{
                        //Visa en felmeddelande
                      }
                      print(mailInput.text);
                      print(passwordInput.text);
                      mailInput.clear();
                      passwordInput.clear();
                    },
 */