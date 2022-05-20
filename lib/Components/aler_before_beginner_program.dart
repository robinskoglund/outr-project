import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Vid anrop, glöm ej barrierDismissible: false,
// showDialog(
// context: context,
// barrierDismissible: false,
// builder: (BuildContext context){
// return AlertBeforeBeginnerProgram(15);
// });

class AlertBeforeBeginnerProgram extends StatelessWidget {
  final int walk_in_minutes;
  final int gym_in_minutes = 25;
  late int total;

  AlertBeforeBeginnerProgram(this.walk_in_minutes) {
    total = this.walk_in_minutes + gym_in_minutes;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text(
        'At the beginning of starting an active lifestyle and want a push to get started? The beginners program will give you just that!',
        style: TextStyle(
          fontSize: 22.0,
          fontFamily: 'Dongle',
          color: Colors.black,
        ),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.directions_walk_rounded,
              color: Colors.black,
              size: 40.0,
            ),
            SizedBox(width: 20.0),
            Text(
              '$walk_in_minutes minutes walk',
              style: TextStyle(
                fontSize: 33.0,
                fontFamily: 'Dongle',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              color: Colors.black,
              size: 40.0,
            ),
            SizedBox(width: 20.0),
            Text(
              '$gym_in_minutes minutes body weight exercises',
              style: TextStyle(
                fontSize: 33.0,
                fontFamily: 'Dongle',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer_outlined,
              color: Colors.black,
              size: 40.0,
            ),
            SizedBox(width: 20.0),
            Text(
              '$total minutes total',
              style: TextStyle(
                fontSize: 33.0,
                fontFamily: 'Dongle',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.circle,
                  size: 10.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  'Brisk walk to nearest outdoor gym',
                  style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 22,
                      color: Colors.black),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.circle,
                  size: 10.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  '10 pushups',
                  style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 22,
                      color: Colors.black),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.circle,
                  size: 10.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  '10 situps',
                  style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 22,
                      color: Colors.black),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.circle,
                  size: 10.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  '10 squats',
                  style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 22,
                      color: Colors.black),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.circle,
                  size: 10.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  '10 back extensions',
                  style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 22,
                      color: Colors.black),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.circle,
                  size: 10.0,
                ),
                SizedBox(width: 5.0),
                Text(
                  'Brisk walk back to starting point',
                  style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 22,
                      color: Colors.black),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              //TODO: implement direction to start route
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Let\'s go!',
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Dongle',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}