import 'dart:math';
import '../ScreenPages/savedroutespage.dart';
import '../ScreenPages/mapviewpage.dart';
import '../ScreenPages/loginviewpage.dart';
import 'package:flutter/material.dart';
import '../Components/navigationbar.dart';

class SavedRoutesPage extends StatelessWidget {

  Widget buildBasicListView(BuildContext context) => ListView(

    children: [
      ListTile(
        leading: Icon(Icons.directions_run, color: Colors.black),
        title: Text("Record round",
            style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        subtitle: Text("40 minute run",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),

        onTap: () => recordRunDialog(context),

      ),
      SizedBox(height: 16),
      Divider(color: Colors.black),
      SizedBox(height: 16),
      ListTile(
        leading: Icon(Icons.dangerous, color: Colors.black),
        title: Text("Escape from the Kids",
            style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        subtitle: Text("20 minute walk",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),
      ),

      SizedBox(height: 16),
      Divider(color: Colors.black),
      SizedBox(height: 16),
      ListTile(
        leading: Icon(Icons.fitness_center, color: Colors.black),
        title: Text("First Gym Workout!",
            style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        subtitle: Text("20 minute walk and 40 minute gym workout",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),
      ),
      Divider(color: Colors.black),
      SizedBox(height: 16),
      ListTile(
        leading: Icon(Icons.directions_run, color: Colors.black),
        title: Text("I'm getting the hang of this!",
            style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        subtitle: Text("60 minute run",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),
      ),
      Divider(color: Colors.black),
      SizedBox(height: 16),
      ListTile(
        leading: Icon(Icons.directions_run, color: Colors.black),
        title: Text("Beautiful sunset run",
            style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        subtitle: Text("40 minute run",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),
      ),
      Divider(color: Colors.black),
      SizedBox(height: 16),
      ListTile(
        leading: Icon(Icons.fitness_center, color: Colors.black),
        title: Text("Heavy Gym Workout in the Sun",
            style: TextStyle(fontFamily: "Dongle", fontSize: 24)),
        subtitle: Text("60 minute gym workout",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),
      ),
      Divider(color: Colors.black),
      SizedBox(height: 16),
      ListTile(
        leading: Icon(Icons.star, color: Colors.black),
        title: Text("Current favorite run",
          style: TextStyle(fontFamily: "Dongle", fontSize: 24),),
        subtitle: Text("50 minute run",
            style: TextStyle(fontFamily: "Dongle", fontSize: 20)),
        trailing: Icon(Icons.share, color: Colors.black),
      ),
      Divider(color: Colors.black),
      SizedBox(height: 16),
    ],
  );


  void recordRunDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Record round",
          style: TextStyle(fontFamily: "Dongle", fontSize: 40)),
      content: Text("Cardio\nRun: 7km\nDuration: 40 minutes\n"
          "*To the right you'll be able to see your route\n"
          "on the map in a future update*",
          style: TextStyle(fontFamily: "Dongle", fontSize: 25)),
      actions: <Widget>[ //dela grejerna, behöver lägga till ikonerna
        //samt färgsättning på knapparna. Ser naket ut, behövs karta?


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
        title: const Text('Saved Routes'),
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