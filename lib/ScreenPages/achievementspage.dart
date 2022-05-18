import 'dart:math';
import '../Components/navigationbar.dart';
import '../ScreenPages/savedroutespage.dart';
import '../ScreenPages/mapviewpage.dart';
import '../ScreenPages/loginviewpage.dart';
import 'package:flutter/material.dart';
import '../Components/timer.dart';

class AchievementsPage extends StatelessWidget {

  Widget buildBasicListView(BuildContext context) => ListView(

    children: [
      ListTile(
        leading: Icon(Icons.redeem_rounded, color: Colors.black),
        title: Text("Gym Rat",
            style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        subtitle: Text("Congratulations!",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),

        onTap: () => gymRatDialog(context),

      ),
      SizedBox(height: 16),
      Divider(color: Colors.black),
      SizedBox(height: 16),

      ListTile(
        leading: Icon(Icons.redeem_rounded, color: Colors.black),
        title: Text("Working the Track",
            style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        subtitle: Text("Congratulations!",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),

        onTap: () => theTrackDialog(context),

      ),

      SizedBox(height: 16),
      Divider(color: Colors.black),
      SizedBox(height: 16),
    ],
  );


  void gymRatDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Gym Rat",
          style: TextStyle(fontFamily: "Dongle", fontSize: 40)),
      content: Text("Congratulations, you've been to the gym 10 times!"
          " You're becoming a Gym Rat!",
          style: TextStyle(fontFamily: "Dongle", fontSize: 28)),
      actions: <Widget>[

        Image.asset("assets/goldmedal.png", width: 400, height: 200,
            fit: BoxFit.contain),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Flexible(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    )
                ),
                child: const Text("Share on Facebook", style: TextStyle(fontFamily: "Dongle",
                    fontSize: 16, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)))),
                child: const Text("Share on Instagram", style: TextStyle(fontFamily: "Dongle",
                    fontSize: 16, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),

            Flexible(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)))
                  ),
                  child: const Text("Share on Pinterest", style: TextStyle(fontFamily: "Dongle",
                      fontSize: 16, fontWeight: FontWeight.normal)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            ),
          ],
        ),
      ],

    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void theTrackDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Working the Track",
          style: TextStyle(fontFamily: "Dongle", fontSize: 40)),
      content: Text("Congratulations, you've ran the same track 5 times, "
          "practice makes perfect!\n"
          "Keep it up, you'll reach your goals in no time!",
          style: TextStyle(fontFamily: "Dongle", fontSize: 28)),
      actions: <Widget>[

        Image.asset("assets/silvermedal.png", width: 400, height: 200,
            fit: BoxFit.contain),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Flexible(
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    )
                ),
                child: const Text("Share on Facebook", style: TextStyle(fontFamily: "Dongle",
                    fontSize: 16, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Flexible(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)))),
                child: const Text("Share on Instagram", style: TextStyle(fontFamily: "Dongle",
                    fontSize: 16, fontWeight: FontWeight.normal)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),

            Flexible(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)))
                  ),
                  child: const Text("Share on Pinterest", style: TextStyle(fontFamily: "Dongle",
                      fontSize: 16, fontWeight: FontWeight.normal)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            ),
          ],
        ),
      ],

    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        foregroundColor: Colors.black, //ändrar färgen på burgarmeny
        title: const Text('Achievements'),
        titleTextStyle: TextStyle(
            fontFamily: "Dongle",
            fontSize: 44,
            color: Colors.black),
        backgroundColor: Colors.white,
      ),
      endDrawer: OutrNavigationBar(),
      body: buildBasicListView(context),

    );
  }

}