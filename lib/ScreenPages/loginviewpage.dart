import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import '../API/dbapihandler.dart';
import 'mapviewpage.dart';
import 'registerviewpage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
        child: Stack(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(70, 10, 70, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: mailInput,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your email',
                          icon: Icon(Icons.person)
                      ),
                    ),
                    TextFormField(
                      controller: passwordInput,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your password',
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ],)
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 150, 70, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
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
                    child: const Text('Login',
                      style:(
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          )
                      ),
                    ),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(10.0),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        side: MaterialStateProperty.all(BorderSide(color: Colors.black26)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        )
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Text('Register',
                      style:(
                          TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          )
                      ),
                    ),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(10.0),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        side: MaterialStateProperty.all(BorderSide(color: Colors.black26)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        )
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 350, 90, 40),
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