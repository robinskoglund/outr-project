import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'navigationbar.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  @override
  _TimerPage createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage> {

  Stopwatch watch = Stopwatch();
  late Timer timer;
  bool startStop = true;
  bool click = false;


  String elapsedTime = '';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(elapsedTime, style: TextStyle(fontSize: 30.0,
              fontFamily: "Dongle", color: Colors.black)),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: "pause/play",
                  backgroundColor: Colors.black,
                  onPressed: () => startOrStop(),
                  child: Icon((click == false) ? Icons.play_arrow_rounded
                      : Icons.pause)),
              SizedBox(width: 20.0),
              FloatingActionButton(
                  heroTag: "restart",
                  backgroundColor: Colors.black,
                  onPressed: () => resetTimer(), //resetWatch,
                  child: Icon(Icons.restart_alt_outlined,
                    color: Colors.white,)),
            ],
          )
        ],
      ),
    );
  }

  startOrStop() {
    if(startStop) {
      click = true;
      startWatch();
    } else {
      stopWatch();
    }
  }

  resetTimer(){
    watch.reset();
    elapsedTime = "";
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      click = false;
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}