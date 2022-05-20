import 'package:flutter/material.dart';
import '../API/dbapihandler.dart';
import '../Components/navigationbar.dart';
import '../DataClasses/userdata.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController mailInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  TextEditingController passwordInput2 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Registration'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
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
              image: AssetImage('assets/backgroundregisterpage.png'),
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
                      controller: nameInput,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Enter your name',
                        errorText: validateName(nameInput.text),
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
                      onPressed: () async {
                        //TODO: Man kan fortfarande klicka på knappen när email inte innehåller @ och när lösen inte stämmer överens


                        addUser(nameInput.text, mailInput.text.toLowerCase());
                        addLogin(mailInput.text.toLowerCase(), passwordInput.text);

                        //Ta sig till din sida eller till logga in sidan på nytt?

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
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
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

  String? validateName(String value) {
    if (value.isEmpty) {
      return "You need to enter your name!";
    }
    return null;
  }
}