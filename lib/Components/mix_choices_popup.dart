import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'outr_icons_icons.dart';

class MixChoices extends StatefulWidget{
  final ChoicesCallback dataCallback;
  final FunctionCallback functionCallback;

  const MixChoices({
    Key? key,
    required this.dataCallback, required this.functionCallback
  }) : super(key: key);

  @override
  State<MixChoices> createState() => _MixChoicesState();
}

class _MixChoicesState extends State<MixChoices>{
  String durationValue = '15';
  int walkOrJogIndex = 0;
  String walkOrRunString = 'Walk';
  bool mixPopup = false;
  bool _refreshRouteShow = false;
  bool _isShow = false;
  late double speed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 70, 30, 0),
      child: Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 25, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height: 380.0,
                width: 350.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 80, 70, 0),
              child: Row(
                children: <Widget>[
                  //Icon or text here -------------------------
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 15.0,
                    activeBgColors: [
                      [Color.fromARGB(255, 43, 121, 255)],
                      [Color.fromARGB(255, 43, 121, 255)]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: Colors.black,
                    initialLabelIndex: walkOrJogIndex,
                    totalSwitches: 2,
                    labels: ['Walk', 'Run'],
                    icons: [Outr_icons.walking, Outr_icons.exercise],
                    iconSize: 30,
                    radiusStyle: true,
                    onToggle: (index) {
                      setState(() {
                        walkOrJogIndex = index!;
                      });
                    },
                  ),
                  //Icon or text here ----------------------------
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(110, 130, 70, 0),
              child: Text('Duration:',
                  style: TextStyle(fontFamily: "Dongle", fontSize: 50)),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(170, 185, 100, 0),
                child: Row(
                  children: <Widget>[
                    DecoratedBox(
                        decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: Colors.black),
                              borderRadius:
                              BorderRadius.all(Radius.circular(0)),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0.0),
                          child: DropdownButton<String>(
                            value: durationValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                durationValue = newValue!;
                              });
                            },
                            underline: SizedBox(),
                            items: <String>[
                              '15',
                              '20',
                              '25',
                              '30',
                              '35',
                              '40',
                              '45',
                              '50',
                              '55',
                              '60'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )),
                    Text(
                      ' min',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 280, 80, 0),
              child: SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 43, 121, 255)),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ))),
                  onPressed: () {
                    setState(() {
                      if (walkOrJogIndex == 1) {
                        walkOrRunString = 'Run:';
                        speed = 2.22;
                      } else {
                        walkOrRunString = 'Walk:';
                        speed = 1.4;
                      }
                      mixPopup = false;
                      _isShow = true;
                      _refreshRouteShow = true;
                    });
                    widget.dataCallback(durationValue, walkOrRunString, mixPopup, _isShow, speed);
                    widget.functionCallback(false);
                  },
                  child: Text('Select',
                      style: TextStyle(fontFamily: "Dongle", fontSize: 50)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef ChoicesCallback = void Function(String durationValue, String walkOrRunString,bool popUp, bool _isShow, double speed);
typedef FunctionCallback = void Function(bool isCardio);