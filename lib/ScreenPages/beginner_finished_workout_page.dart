import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinishedWorkoutPage extends StatefulWidget {
  @override
  _FinishedWorkoutState createState() => _FinishedWorkoutState();
}

class _FinishedWorkoutState extends State<FinishedWorkoutPage> {
  bool checkbox_one = false;
  bool checkbox_two = false;
  bool checkbox_three = false;
  bool checkbox_four = false;
  bool checkbox_five = false;
  bool checkbox_six = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(
          'Finished Workout',
          style: TextStyle(
            fontFamily: 'Dongle',
            fontSize: 50,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            initialValue: 'Beginner Program',
            style: TextStyle(
              fontFamily: 'Dongle',
              fontSize: 40,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              suffixIcon: Icon(Icons.edit),
              suffixIconColor: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkbox_one,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                activeColor: Colors.greenAccent,
                onChanged: (bool? newValue) {
                  setState(() {
                    checkbox_one = newValue!;
                  });
                },
              ),
              Text(
                'Brisk walk to nearest outdoor gym',
                style: TextStyle(
                    fontFamily: 'Dongle', fontSize: 22, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkbox_two,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                activeColor: Colors.greenAccent,
                onChanged: (bool? newValue) {
                  setState(() {
                    checkbox_two = newValue!;
                  });
                },
              ),
              Text(
                '10 pushups',
                style: TextStyle(
                    fontFamily: 'Dongle', fontSize: 22, color: Colors.black),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkbox_three,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                activeColor: Colors.greenAccent,
                onChanged: (bool? newValue) {
                  setState(() {
                    checkbox_three = newValue!;
                  });
                },
              ),
              Text(
                '10 situps',
                style: TextStyle(
                    fontFamily: 'Dongle', fontSize: 22, color: Colors.black),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkbox_four,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                activeColor: Colors.greenAccent,
                onChanged: (bool? newValue) {
                  setState(() {
                    checkbox_four = newValue!;
                  });
                },
              ),
              Text(
                '10 squats',
                style: TextStyle(
                    fontFamily: 'Dongle', fontSize: 22, color: Colors.black),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkbox_five,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                activeColor: Colors.greenAccent,
                onChanged: (bool? newValue) {
                  setState(() {
                    checkbox_five = newValue!;
                  });
                },
              ),
              Text(
                '10 back extensions',
                style: TextStyle(
                    fontFamily: 'Dongle', fontSize: 22, color: Colors.black),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkbox_five,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                activeColor: Colors.greenAccent,
                onChanged: (bool? newValue) {
                  setState(() {
                    checkbox_five = newValue!;
                  });
                },
              ),
              Text(
                'Brisk walk back to starting point',
                style: TextStyle(
                    fontFamily: 'Dongle', fontSize: 22, color: Colors.black),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '31.20',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Min',
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
                    '2,02',
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
                    '12,47',
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
                  primary: Colors.red,
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 30,
                    color: Colors.white,
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
                onPressed: () {},
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 30,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}