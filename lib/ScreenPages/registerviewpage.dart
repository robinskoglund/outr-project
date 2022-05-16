import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController mailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  TextEditingController passwordInput2 = TextEditingController();

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
                  children: <Widget>[
                    TextFormField(
                      controller: mailInput,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Enter your email',
                        errorText: validateEmail(mailInput.text),
                        icon: const Icon(Icons.person),
                      ),
                    ),
                    TextFormField(
                      controller: passwordInput,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Enter your password',
                        errorText: validatePassword(passwordInput.text),
                        icon: const Icon(Icons.lock),
                      ),
                    ),
                    TextFormField(
                      controller: passwordInput2,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Enter your password again',
                        errorText: validatePassword(passwordInput2.text),
                        icon: const Icon(Icons.lock),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //TODO: Vad händer när man registrerar
                        print(passwordInput.text);
                        print(passwordInput2.text);
                      },
                      child: const Text('OK',
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
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "You need to enter a password!";
    }
    if(passwordInput.text != passwordInput2.text){
      return "Passwords do not match!";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "You need to enter a Email!";
    }
    if(!value.contains('@')){
      return "Email format is wrong!";
    }
    return null;
  }
}