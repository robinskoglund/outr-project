import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertBeforeBeginnerProgram extends StatelessWidget {
  final ValueChanged<bool> updateAlertBeforeBeginner;

  AlertBeforeBeginnerProgram({required this.updateAlertBeforeBeginner});

  //Alert popup gällande introduktionsprogrammet
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: 400,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'At the beginning of starting an active lifestyle and want a push to get started? OutR introduction program will give you just that!',
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: 'Dongle',
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.directions_walk,
                  color: Colors.black,
                  size: 20.0,
                ),
                SizedBox(width: 2.0),
                Text('20 minutes walk*',
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              '*This is only an estimate, take it at your own pace',
              style: TextStyle(
                fontFamily: 'Dongle',
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding:
                EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {
                return updateAlertBeforeBeginner(false);
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
      ),
    );
  }
}