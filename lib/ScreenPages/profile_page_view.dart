import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Components/navigation_bar.dart';
import '../DataClasses/userdata.dart';
import 'achievements_page.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen(this.user);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  String currentLevel = '';
  String currentStreak = '';
  String currentExperience = '';
  String currentRank = '';
  String accountLoggedIn = '';
  String xpToNextLevel = '';

  double xpBarWidth = 0;
  int currentLevelInt = 0;
  int currentExperienceInt = 0;
  int xpToNextLevelInt = 0;
  int totalXpForNextLevel = 0;

  @override
  void initState() {
    currentLevel = widget.user.level.toString();
    currentStreak = widget.user.dailyStreak.toString();
    currentExperience = widget.user.xp.toString();
    currentRank = widget.user.rank.toString();
    xpToNextLevel = widget.user.xpToNextLevel.toString();
    accountLoggedIn = widget.user.email.toString();

    currentLevelInt = widget.user.level;
    currentExperienceInt = widget.user.xp;
    xpToNextLevelInt = widget.user.xpToNextLevel;
    totalXpForNextLevel = widget.user.totalXpForNextLevel;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold som innehåller allt som finns på profilsidan
    return Scaffold(
      endDrawer: OutrNavigationBar(widget.user),
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height: 630.0,
                width: 400.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(145, 20, 80, 0),
              child: Text(
                'Level: $currentLevel',
                style: const TextStyle(
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
                style: const TextStyle(
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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/profileavatar.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(210, 280, 45, 0),
              child: Text(
                '$xpToNextLevel xp to',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontFamily: 'Dongle',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 300, 50, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Stack(
                    children:<Widget> [
                      //This is the exp-bar
                      Container(
                        height: 40,
                        width: getXpBarWidth(),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[700],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      //This is the full bar
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 4.0, color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(width: 8.0),
                            Text(
                              '$currentExperience xp',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontFamily: 'Dongle',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'level up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontFamily: 'Dongle',
                    ),
                  ),
                ],
              ),
            ),


            Padding(
                padding: const EdgeInsets.fromLTRB(80, 390, 80, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$currentStreak workouts',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontFamily: 'Dongle',
                      ),
                    ),
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/hotstreak.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                )
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(150, 420, 80, 0),
              child: Text(
                'streak',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Dongle',
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(85, 520, 80, 10),
                child: SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 43, 121, 255)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        )
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AchievementsPage(widget.user)),
                      );
                    },
                    child: Text(
                        'Achievements',
                        style: TextStyle(
                            fontFamily: "Dongle",
                            fontSize: 42
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

  //Funktion för att räkna ut hur många pixlar expbaren skall visa
  double getXpBarWidth(){
    double xpPerPixel = totalXpForNextLevel/150;
    return xpBarWidth = (totalXpForNextLevel - xpToNextLevelInt) / xpPerPixel;
  }
}