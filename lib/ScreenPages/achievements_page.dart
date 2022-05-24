import 'dart:math';
import '../Components/navigation_bar.dart';
import 'package:flutter/material.dart';

import '../DataClasses/userdata.dart';

class AchievementsPage extends StatelessWidget {
  final User user;

  AchievementsPage(this.user);

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

  //buildBasicListView(context)

  Widget buildBasicListView(BuildContext context) =>
      ListView(

        children: [
          ListTile(
            leading: Image.asset(
                "assets/goldmedal.png", width: 100, height: 100,
                fit: BoxFit.contain),
            title: const Text("60 minute run!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
            subtitle: const Text("Completed!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
            trailing: const Icon(
                Icons.facebook_rounded, color: Colors.blue, size: 30),

            onTap: () => sixtyMinuteRun(context),

          ),
          SizedBox(height: 16),
          Divider(color: Colors.black),
          SizedBox(height: 16),

          ListTile(
            leading: Image.asset(
                "assets/silvermedal.png", width: 100, height: 100,
                fit: BoxFit.contain),
            title: Text("30 minute walk!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
            subtitle: Text("Completed!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
            trailing: Icon(
                Icons.facebook_rounded, color: Colors.blue, size: 30),

            onTap: () => thirtyMinuteRun(context),

          ),
          SizedBox(height: 16),
          Divider(color: Colors.black),
          SizedBox(height: 16),

          //KOD FÖR BEGINNER WORKOUT ACHIVEMENTEN.
          ListTile(
            leading: Image.asset(
                "assets/bronzemedal.png", width: 100, height: 100,
                fit: BoxFit.contain),
            title: Text("Beginner workout!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
            subtitle: Text("Completed!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
            trailing: Icon(
                Icons.facebook_rounded, color: Colors.blue, size: 30),

            onTap: () => beginnerWorkout(context),

          ),
          SizedBox(height: 16),
          Divider(color: Colors.black),
          SizedBox(height: 16),
        ],
      );

  void sixtyMinuteRun(BuildContext context) {
    var alert = AlertDialog(
      title: Text("60 minute run!", textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 40)),
      content: Text("Congratulations!\nYou completed a 60 minute run!",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 28)),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      actions: <Widget>[

        Image.asset("assets/goldmedal.png", width: 400, height: 200,
            fit: BoxFit.contain),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    )
                ),
                child: const Text(
                    "Share on Facebook", style: TextStyle(fontFamily: "Dongle",
                    fontSize: 24, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],

    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void thirtyMinuteRun(BuildContext context) {
    var alert = AlertDialog(
      title: Text("30 minute walk!", textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 40)),
      content: Text("Congratulations \nYou completed a 30 minute walk!",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 28)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      actions: <Widget>[

        Image.asset("assets/silvermedal.png", width: 400, height: 200,
            fit: BoxFit.contain),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    )
                ),
                child: const Text(
                    "Share on Facebook", style: TextStyle(fontFamily: "Dongle",
                    fontSize: 24, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],

    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  // KOD FÖR BEGINNERWORKOUT ACHIVEMENT, FUNGERAR KORREKT FÖRUTOM IKONEN!
  void beginnerWorkout(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Beginner workout!", textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 40)),
      content: Text("Congratulations \nYou completed the Beginner workout!",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 28)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      actions: <Widget>[

        Image.asset("assets/bronzemedal2.png", width: 400, height: 200,
            fit: BoxFit.contain),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    )
                ),
                child: const Text(
                    "Share on Facebook", style: TextStyle(fontFamily: "Dongle",
                    fontSize: 24, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],

    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}