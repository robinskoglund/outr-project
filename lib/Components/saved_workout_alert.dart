import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outr/ScreenPages/saved_routes_page.dart';
import '../DataClasses/userdata.dart';
import '../ScreenPages/mapview_page.dart';

//Kan anropas så här:
// showDialog(context: context,
// builder: (BuildContext context){
// return SavedWorkoutAlert('Beginner Program');},);

class SavedWorkoutAlert extends StatelessWidget{

  final String nameOfWorkout;
  final User user;

  SavedWorkoutAlert(this.nameOfWorkout, this.user);

  //Popupen som kommer när man ska spara en rutt
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0,10.0),
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Text(
                'Saved',
                style:  TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'Dongle',
                  color: Colors.black,
                ),
              ),

              Center(
                child: ClipRect(
                  child: Image.asset('assets/SavedDude.png'),
                ),
              ),

              Text(
                'Your workout',
                style:  TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Dongle',
                  color: Colors.black,
                ),
              ),

              Text(
                '$nameOfWorkout',
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontSize: 45.0,
                  fontFamily: 'Dongle',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              Text(
                'has been saved',
                style:  TextStyle(
                  fontSize: 45.0,
                  fontFamily: 'Dongle',
                  color: Colors.black,
                ),
              ),

              ElevatedButton(
                style:ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.fromLTRB(30.0, 3.0, 30.0, 3.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                //TODO: implement direction to saved routes
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SavedRoutesPage(user)),
                  );
                },
                child:Text(
                  'Go to your routes',
                  style:  TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Dongle',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 15.0),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                //TODO: implement direction to start
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MapScreen(showPopUp: false, user: user)),
                  );
                },
                child: Text(
                  'Back to start',
                  style:  TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Dongle',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}