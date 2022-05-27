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

        centerTitle: true,
        title: const Text('Achievements',style: TextStyle(fontFamily: "Dongle",
            fontSize: 45)),
        backgroundColor: Colors.white,
      ),
      endDrawer: OutrNavigationBar(user),

      body: Container(
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                "assets/outrmedal.png", width: 100, height: 100,
                fit: BoxFit.contain),
            title: Text("OutR trainee",
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

          ListTile(
            leading: Image.asset("assets/cardiomedal.png", width: 100, height: 100, ///
                fit: BoxFit.contain),
            title: const Text("First Cardio workout",
                style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
            subtitle: const Text("Completed!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
            trailing: const Icon(
                Icons.facebook_rounded, color: Colors.blue, size: 30),

            onTap: () => firstCardioWorkout(context),

          ),
          SizedBox(height: 16),
          Divider(color: Colors.black),
          SizedBox(height: 16),

          ListTile(
            leading: Image.asset(
                "assets/strengthmedal.png", width: 100, height: 100,
                fit: BoxFit.contain),
            title: Text("First Strength workout",
                style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
            subtitle: Text("Completed!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
            trailing: Icon(
                Icons.facebook_rounded, color: Colors.blue, size: 30),

            onTap: () => firstStrengthWorkout(context),

          ),
          SizedBox(height: 16),
          Divider(color: Colors.black),
          SizedBox(height: 16),

          ListTile(
            leading: Image.asset(
                "assets/mixmedal.png", width: 100, height: 100,
                fit: BoxFit.contain),
            title: Text("First Mix workout",
                style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
            subtitle: Text("Completed!",
                style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
            trailing: Icon(
                Icons.facebook_rounded, color: Colors.blue, size: 30),

            onTap: () => firstMixWorkout(context),

          ),
          SizedBox(height: 16),
          Divider(color: Colors.black),
          SizedBox(height: 16),

        ],
      );

  void firstCardioWorkout(BuildContext context) {
    var alert = AlertDialog(
      title: Text("First Cardio workout", textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 35)),
      content: Text("Congratulations!\nYou've completed your first Cardio workout. \n Keep running!",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 25, fontWeight: FontWeight.w200,)),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      actions: <Widget>[

        Image.asset("assets/cardiomedal.png", width: 400, height: 200,
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

  void firstStrengthWorkout(BuildContext context) {
    var alert = AlertDialog(
      title: Text("First Strength workout", textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 35)),
      content: Text("Congratulations! \nYou've completed your first Strength workout. \n Keep lifting!",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 25, fontWeight: FontWeight.w200,)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      actions: <Widget>[

        Image.asset("assets/strengthmedal.png", width: 400, height: 200,
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

  void firstMixWorkout(BuildContext context) {
    var alert = AlertDialog(
      title: Text("First Mix workout", textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 35)),
      content: Text("Congratulations! \nYou've completed your first Mix workout. \n Keep running and lifting!",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 25, fontWeight: FontWeight.w200,)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      actions: <Widget>[

        Image.asset("assets/mixmedal.png", width: 400, height: 200,
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

  void beginnerWorkout(BuildContext context) {
    var alert = AlertDialog(
      title: Text("OutR trainee", textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 35)),
      content: Text("Congratulations!\nYou've completed the OutR Introduction Program. \n Welcome to OutR, fellow OutRer!",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Dongle", fontSize: 25, fontWeight: FontWeight.w200,)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      actions: <Widget>[

        Image.asset("assets/outrmedal.png", width: 400, height: 200,
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