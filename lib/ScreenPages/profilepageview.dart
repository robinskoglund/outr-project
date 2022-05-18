import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Components/navigationbar.dart';
import 'achievementspage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  int currentLevel = 1;
  int currentStreak = 0;
  int currentExperience = 0;
  String currentRank = 'Rookie';
  String accountLoggedIn = 'testoutr@gmail.se';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OutrNavigationBar(),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(accountLoggedIn),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height: 550.0,
                width: 400.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(145, 20, 80, 0),
              child: Text(
                'Level: $currentLevel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Dongle',
                  letterSpacing: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(165, 50, 80, 0),
              child: Text(
                '$currentRank',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Dongle',
                  letterSpacing: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(220, 110, 60, 0),
              child: Container(
                height: 150.0,
                width: 160.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/profileavatar.png'),
                    fit: BoxFit.fill,
                  ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(225, 270, 0, 0),
              child: Text(
                '480 xp to',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Dongle',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(235, 300, 0, 0),
              child: Text(
                'level up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Dongle',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(120, 400, 80, 0),
              child: Row(
                children: <Widget>[
                  Text(
                    '$currentStreak workouts \n   streak',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'Dongle',
                    ),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/hotstreak.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              )
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(85, 530, 80, 10),
                child: SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 43, 121, 255)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        )
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AchievementsPage()),
                      );
                    },
                    child: Text(
                        'Achievements',
                        style: TextStyle(
                            fontFamily: "Dongle",
                            fontSize: 50
                        )
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}