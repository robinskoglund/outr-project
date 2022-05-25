import 'package:flutter/material.dart';
import 'package:outr/Components/navigation_bar.dart';
import '../Components/saved_workout_alert.dart';
import '../DataClasses/userdata.dart';
import 'mapview_page.dart';
import  'package:intl/intl.dart';

class FinishedWorkoutPage extends StatefulWidget {
  final User user;
  final String exercisetypeInLowerCase_beginner_cardio_gym_mix;
  final String minutes;
  final double kilometers;
  final String minPerKM;

  FinishedWorkoutPage(
      this.user,
      this.exercisetypeInLowerCase_beginner_cardio_gym_mix,
      this.minutes,
      this.kilometers,
      this.minPerKM);

  @override
  State<FinishedWorkoutPage> createState() => _FinishedWorkoutPageState();
}

class _FinishedWorkoutPageState extends State<FinishedWorkoutPage> {
  final String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  late String title = getTitle();
  late String minutes = getMinutes();
  late double kilometers = getKilometers();
  late String minPerKM = getMinPerKM();

  String getTitle() {
    if (widget.exercisetypeInLowerCase_beginner_cardio_gym_mix == 'beginner')
      return title = 'Beginner workout $date';
    else if (widget.exercisetypeInLowerCase_beginner_cardio_gym_mix == 'cardio')
      return title = 'Cardio $date';
    else if (widget.exercisetypeInLowerCase_beginner_cardio_gym_mix == 'gym')
      return title = 'Strength $date';
    else
      return title = 'Mix + $date';
  }

  String getMinutes() {
    return minutes = widget.minutes;
  }

  double getKilometers() {
    return kilometers = widget.kilometers;
  }

  String getMinPerKM() {
    return minPerKM = widget.minPerKM;
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
          ),
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$minutes',
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
                    '$kilometers',
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
                onPressed: () {
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SavedWorkoutAlert('$title', widget.user);
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
            Navigator.of(context).pop();
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