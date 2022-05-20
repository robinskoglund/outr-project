import '../Components/navigationbar.dart';
import '../DataClasses/userdata.dart';
import '../ScreenPages/savedroutespage.dart';
import '../ScreenPages/mapviewpage.dart';
import '../ScreenPages/loginviewpage.dart';
import 'package:flutter/material.dart';

class StrengthFinPage extends StatelessWidget {
  final User user;

  StrengthFinPage(this.user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        foregroundColor: Colors.black,
        //ändrar färgen på burgarmeny
        centerTitle: true,
        title: const Text('Finished Workout'),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(fontFamily: "Dongle",
        color: Colors.black),
      ),
      endDrawer: OutrNavigationBar(user),
      body: Container(
        color: Colors.grey[200],
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,

        child: Stack(
            children: <Widget>[
        Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
          ),
          height: 530.0,
          width: 400.0,
        ),
      ),
          Padding(
            padding: const EdgeInsets.fromLTRB(125, 20, 80, 0),
                child: Text(
                "Farsta Utegym",
                  style: const TextStyle(
                   color: Colors.black,
                    fontSize: 35,
                      fontWeight: FontWeight.bold,
                        fontFamily: 'Dongle',
                          letterSpacing: 1,
                          ),
                  textAlign: TextAlign.center,
                            ),
                              ),
              SizedBox(height: 10),



          ],
        ),
      ),
    );
  }

}