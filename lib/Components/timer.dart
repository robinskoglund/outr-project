import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'navigationbar.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  @override
  _TimerPage createState() => _TimerPage();
}

class _TimerPage extends State<TimerPage> {

  Stopwatch _watch = Stopwatch();
  late Timer _timer;
  bool _startStop = true;
  bool _click = false;

  String _elapsedTime = '';

  updateTime(Timer timer) {
    if (_watch.isRunning) {
      setState(() {
        _elapsedTime = transformMilliSeconds(_watch.elapsedMilliseconds);
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(_elapsedTime, style: TextStyle(fontSize: 30.0,
              fontFamily: "Dongle", color: Colors.black)),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: "pause/play",
                  backgroundColor: Colors.black,
                  onPressed: () => startOrStop(),
                  child: Icon((_click == false) ? Icons.play_arrow_rounded
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
    if(_startStop) {
      _click = true;
      startWatch();
    } else {
      stopWatch();
    }
  }

  resetTimer(){
    _watch.reset();
    _elapsedTime = "";
  }

  startWatch() {
    setState(() {
      _startStop = false;
      _watch.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      _click = false;
      _startStop = true;
      _watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = _watch.elapsedMilliseconds;
    setState(() {
      _elapsedTime = transformMilliSeconds(timeSoFar);
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