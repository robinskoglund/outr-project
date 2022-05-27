import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outr/ScreenPages/cardio_start_page.dart';
import 'package:outr/ScreenPages/mix_start_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../DataClasses/userdata.dart';
import '../ScreenPages/finished_gym_workout.dart';
import '../ScreenPages/mapview_page.dart';

class SlidingUpWidget extends StatefulWidget {
  final PanelController panelController;
  final ButtonChoiceCallback chooseButton;
  final User user;

  const SlidingUpWidget({
    Key? key,
    required this.panelController,
    required this.chooseButton, required this.user,
  }) : super(key: key);

  @override
  State<SlidingUpWidget> createState() => _SlidingUpWidgetState();
}

class _SlidingUpWidgetState extends State<SlidingUpWidget> {
  bool _endWorkout = false;
  bool _isActive = false;
  bool _isPaused = false;
  String _playPause = 'Play';
  String _sliderHeader = 'Start';

  Stopwatch _watch = Stopwatch();
  late Timer _timer;
  bool _startStop = true;
  bool _click = false;

  String _elapsedTime = '00:00';

  @override
  Widget build(BuildContext context) => ListView(
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.zero,

    children: <Widget>[
      const SizedBox(height: 15),
      openUpPanelDragHandle(),
      Center(
        child: ElevatedButton(
            onPressed: () {
              togglePanelUpDown();
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(390, 30)),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
              elevation: MaterialStateProperty.all<double>(0),
            ),
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Visibility(
                      visible: !_isActive,
                      child: Text(
                        _sliderHeader,
                        style: const TextStyle(
                          fontSize: 60.0,
                          letterSpacing: 1.5,
                          color: Colors.blueGrey,
                          fontFamily: 'Dongle',
                        ),
                      ),
                    ),
                    Visibility(
                        visible: _isActive,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(_elapsedTime,
                                    style: const TextStyle(
                                        fontFamily: 'Dongle',
                                        fontSize: 50,
                                        color: Colors.black)),
                                const Text("0:00",
                                    style: TextStyle(
                                        fontFamily: 'Dongle',
                                        fontSize: 50,
                                        color: Colors.black)),
                                const Text("0:00",
                                    style: TextStyle(
                                        fontFamily: 'Dongle',
                                        fontSize: 50,
                                        color: Colors.black)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text("Min",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontSize: 30,
                                          color: Colors.black)),
                                  Text("      KM",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontSize: 30,
                                          color: Colors.black)),
                                  Text("Arrival",
                                      style: TextStyle(
                                          fontFamily: 'Dongle',
                                          fontSize: 30,
                                          color: Colors.black)),
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                )
              ],
            )),
      ),
      Visibility(
        visible: !_isActive,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: Container(
                width: 300,
                height: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    ElevatedButton.icon(

                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          )),
                      icon: Image.asset('assets/cardioDude.png'),
                      label: const Text('Cardio',
                          style: TextStyle(
                              fontFamily: 'Dongle', fontSize: 50)),
                      onPressed: () {
                        changeState();
                        widget.chooseButton(2);
                        widget.panelController.close();
                      },
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          )),
                      icon: Image.asset('assets/strengthDude.png'),
                      label: const Text('Strength',
                          style: TextStyle(
                              fontFamily: 'Dongle', fontSize: 50)),
                      onPressed: () {
                        changeState();
                        widget.chooseButton(3);
                        widget.panelController.close();
                      },
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          )),
                      icon: Image.asset('assets/mixDude.png'),
                      label: const Text('Mix',
                          style: TextStyle(
                              fontFamily: 'Dongle', fontSize: 50)),
                      onPressed: () {
                        changeState();
                        widget.chooseButton(4);
                        widget.panelController.close();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Visibility(
        visible: _isActive,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: Container(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              Text(
                                "0,00",
                                style: TextStyle(
                                  fontSize: 60.0,
                                  letterSpacing: 1.5,
                                  color: Colors.black,
                                  fontFamily: 'Dongle',
                                ),
                              ),
                              Text("0,00",
                                  style: TextStyle(
                                    fontSize: 60.0,
                                    letterSpacing: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Dongle',
                                  )),
                            ]),
                        Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              Text("KM left",
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    letterSpacing: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Dongle',
                                  )),
                              Text("Min/KM",
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    letterSpacing: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Dongle',
                                  ))
                            ]),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.black,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          )),
                      icon: Icon(
                          (_isPaused == false)
                              ? Icons.play_arrow
                              : Icons.pause_circle,
                          size: 40),
                      label: Text(_playPause,
                          style: const TextStyle(
                              fontFamily: 'Dongle', fontSize: 50)),
                      onPressed: () {
                        togglePanelUpDown();
                        setState(() {
                          setPlayPause();

                          startOrStop();
                        });
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red,
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          )),
                      child: const Text('End',
                          style: TextStyle(
                              fontFamily: 'Dongle', fontSize: 50)),
                      onPressed: () {
                        endWorkoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget openUpPanelDragHandle() => GestureDetector(
    child: Center(

      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.005,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    onTap: togglePanelUpDown,
  );

  void endWorkout(bool endWorkout) { //om man vill avsluta så körs denna metod
    if(endWorkout == true) {
      stopWatch();
      resetTimer();
      _isPaused = false;
      _playPause = "Play";
      widget.chooseButton(5);
      widget.panelController.close();
    }
  }

  void endWorkoutDialog(BuildContext context) {
    var alert = AlertDialog(
      title: Text("End workout",
          style: TextStyle(fontFamily: "Dongle", fontSize: 40)),
      content: Text("Do you wish to end your current workout?",
          style: TextStyle(fontFamily: "Dongle", fontSize: 25)),
      actions: <Widget>[
        TextButton(onPressed: () {
          Navigator.of(context).pop();
          _endWorkout = false; //sätter att man vill avsluta till false
        },
          child: Text("Cancel", style: TextStyle(color: Colors.black,
              fontFamily: 'Dongle', fontSize: 30),),
        ),
        SizedBox(width: 5.0),


        TextButton(onPressed: () {
          _endWorkout = true;  //sätter att man vill avsluta till ja
          endWorkout(_endWorkout);
          Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => //skickar användaren
          //till FinishedGymWorkout sidan
          FinishedGymWorkoutPage(widget.user)));
        },
          child: Text("End", style: TextStyle(color: Colors.red,
              fontFamily: 'Dongle', fontSize: 30),),
        ),
        SizedBox(width: 5.0),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
    //visar alerten

  }

  void changeState() {
    setState(() {
      if (!_isActive) {
        _isActive = true;
      } else {
        _isActive = false;
      }
    });
  }

  //Den här skiten funkar ju bara när den är nere
  void togglePanelUpDown() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  void setPlayPause () {
    if (_isPaused) {
      _playPause = 'Play';

    } else {
      _playPause = 'Pause';
    }
    _isPaused = !_isPaused;
  }

  startOrStop() {
    if (_startStop) {
      _click = true;
      startWatch();
    } else {
      stopWatch();
    }
  }

  resetTimer() {
    _watch.reset();
    _elapsedTime = "00:00";
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
    // int hours = (minutes / 60).truncate();

    // String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  updateTime(Timer timer) {
    if (_watch.isRunning) {
      setState(() {
        _elapsedTime = transformMilliSeconds(_watch.elapsedMilliseconds);
      });
    }
  }
}

typedef ButtonChoiceCallback = void Function(int buttonNumber);