import 'package:flutter/material.dart';
import 'package:outr/API/dbapihandler.dart';
import 'package:outr/Components/navigation_bar.dart';
import '../Components/saved_workout_alert.dart';
import '../DataClasses/userdata.dart';
import 'mapview_page.dart';
import  'package:intl/intl.dart';

class FinishedWorkoutPage extends StatefulWidget {
  User user;
  final int buttonSelection;
  final String elapsedTime;
  final String distance;
  final String minPerKM;
  final String route;

  FinishedWorkoutPage(
      this.user,
      this.buttonSelection,
      this.elapsedTime,
      this.distance,
      this.minPerKM,
      this.route);

  @override
  State<FinishedWorkoutPage> createState() => _FinishedWorkoutPageState();
}

class _FinishedWorkoutPageState extends State<FinishedWorkoutPage> {
  final String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  late String title = getTitle();
  late int buttonSelection;
  late String elapsedTime;
  late String distance;
  late String minPerKM;
  late String email;
  late String route;
  late String achievementText;
  late String typeOfWorkout;

  @override
  void initState(){
    buttonSelection = widget.buttonSelection;
    elapsedTime = widget.elapsedTime;
    distance = widget.distance;
    minPerKM = widget.minPerKM;
    email = widget.user.email;
    route = widget.route;
    super.initState();
  }

  String getAchievementText(){
    if (buttonSelection == 1)
      return achievementText = 'Completed the OutR workout!';
    else if (buttonSelection == 2)
      return typeOfWorkout = 'Your first cardio workout completed';
    else if (buttonSelection == 3)
      return typeOfWorkout = 'Your first strength workout completed';
    else
      return typeOfWorkout = 'Your first mix workout completed';
  }

  void setTitle(String newTitle){
    this.title = newTitle;
  }

  String getTitle() {
    if (buttonSelection == 1)
      return title = 'Beginner workout $date';
    else if (buttonSelection == 2)
      return title = 'Cardio $date';
    else if (buttonSelection == 3)
      return title = 'Strength $date';
    else
      return title = 'Mix $date';
  }

  String getTypeOfWorkout(){
    if (buttonSelection == 1)
      return typeOfWorkout = 'Beginner workout';
    else if (buttonSelection == 2)
      return typeOfWorkout = 'Cardio';
    else if (buttonSelection == 3)
      return typeOfWorkout = 'Strength';
    else
      return typeOfWorkout = 'Mix';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OutrNavigationBar(widget.user),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Finished Workout',
            style: TextStyle(fontFamily: "Dongle", fontSize: 45)),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          TextFormField(
              textAlign: TextAlign.center,
              initialValue: '$title',
              style: TextStyle(
                fontFamily: 'Dongle',
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                suffixIcon: Icon(Icons.edit),
                suffixIconColor: Colors.black,
              ),
              onChanged: (text){
                setTitle(text);
              }
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$elapsedTime',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Minutes',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Text>[
                  Text(
                    '$distance',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'KM',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Text>[
                  Text(
                    '$minPerKM',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Min/KM',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () async {
                  saveAchievement(email, getAchievementText(), getTypeOfWorkout());

                  double distanceAsDouble = double.parse(distance);
                  distanceAsDouble *= 1000;
                  int distanceAsInt = distanceAsDouble.toInt();
                  updateXp(email, distanceAsInt);

                  widget.user = await getUser(email);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return endWorkoutAlert(widget.user);
                    },
                  );
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 34,
                    color: Colors.red,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () async {

                  //Skicka till db
                  distance = distance.replaceAll(' km', '');
                  saveRoute(email, route, getTypeOfWorkout(), distance, title, elapsedTime);
                  saveAchievement(email, getAchievementText(), getTypeOfWorkout());

                  double distanceAsDouble = double.parse(distance);
                  distanceAsDouble *= 1000;
                  int distanceAsInt = distanceAsDouble.toInt();
                  updateXp(email, distanceAsInt);

                  widget.user = await getUser(email);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SavedWorkoutAlert(title, widget.user);
                    },
                  );
                }, //lägg till så rutten sparas
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 34,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class endWorkoutAlert extends StatelessWidget {
  final User user;
  const endWorkoutAlert(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete workout', style: TextStyle(fontFamily: 'Dongle', fontSize: 40),),
      content: Text('Do you wish delete your workout?', style: TextStyle(fontFamily: 'Dongle', fontSize: 30),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapScreen(
                user: user, showPopUp: false)),
      );
    },
          child: Text(
            'Cancel',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Dongle',
                fontSize: 33),
          ),
        ),
        SizedBox(width: 20.0),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MapScreen(showPopUp: false, user: user)),
            );
          },
          child: Text(
            'Delete',
            style: TextStyle(
                color: Colors.red,
                fontFamily: 'Dongle',
                fontSize: 33),
          ),
        ),
      ],
    );
  }
}