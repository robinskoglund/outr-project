import 'dart:math';
import 'package:outr/API/dbapihandler.dart';
import 'package:outr/DataClasses/achievementdata.dart';
import '../Components/navigation_bar.dart';
import 'package:flutter/material.dart';
import '../DataClasses/userdata.dart';

class AchievementsPage extends StatefulWidget {
  final User user;

  AchievementsPage(this.user);

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  List<Achievement>? achievements;

  void getAchievements() async {
    final allAchievements = await getAllUserAchievements(widget.user.email);
    setState(() {
      achievements = allAchievements;
    });
  }

  @override
  void initState() {
    getAchievements();
    super.initState();
  }

  //buildBasicListView(context)
  Widget buildBasicListView(BuildContext context) {
    if (achievements != null) {
      return ListView(
        children: <Widget>[
          for(Achievement myAchievement in achievements!)
            MyAchievement(myAchievement.achievementText,
                myAchievement.achievementLevel
            ),
        ],
      );
    }
    return ListView(
      children: <Widget>[
        SizedBox(height: 30.0),
        ListTile(
          leading: Image.asset('assets/sadDude.png'),
          title: Text('Achievements are empty',
              style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        ),
      ],
    );
  }

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
        title: const Text('Achievements'),
        backgroundColor: Colors.white,
      ),
      endDrawer: OutrNavigationBar(widget.user),
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
              padding: const EdgeInsets.fromLTRB(40, 25, 25, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height: 370.0,
                width: 330.0,
                child: buildBasicListView(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAchievement extends StatelessWidget {
  final String text;
  final String level;

  MyAchievement(this.text, this.level);

  @override
  Widget build(BuildContext context) {
    String image;

    //Fler level-typer kan läggas till
    if (level == 'beginner workout')
      image = 'assets/outrmedal.png';
    else if (level == 'Strength')
      image = 'assets/strengthmedal.png';
    else if (level == 'Cardio')
      image = 'assets/cardiomedal.png';
    else
      image = 'assets/mixmedal.png';

    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        ListTile(
          leading: Image.asset(image),
          title: Text(
            text,
            style: TextStyle(fontFamily: "Dongle", fontSize: 24),
          ),
          subtitle: Text(
            '$level',
            style: TextStyle(fontFamily: "Dongle", fontSize: 20),
          ),
        ),
        Divider(color: Colors.black),
        SizedBox(height: 16),
      ],
    );
  }
}
