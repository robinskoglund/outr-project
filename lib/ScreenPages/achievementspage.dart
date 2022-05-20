import 'dart:math';
import '../Components/navigationbar.dart';
import '../ScreenPages/savedroutespage.dart';
import '../ScreenPages/mapviewpage.dart';
import '../ScreenPages/loginviewpage.dart';
import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        foregroundColor: Colors.black, //ändrar färgen på burgarmeny
        centerTitle: true,
        title: const Text('Achievements'),
        backgroundColor: Colors.white,
      ),
      endDrawer: OutrNavigationBar(),
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
          ],
        ),
      ],

    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}