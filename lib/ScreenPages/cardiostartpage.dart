import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:outr/Components/outr_icon_icons.dart';
import 'package:outr/Components/outr_icons_icons.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../Components/navigationbar.dart';



class CardioStartPage extends StatefulWidget {
  @override
  State<CardioStartPage> createState() => _CardioStartPageState();
}
//hej
class _CardioStartPageState extends State<CardioStartPage> {
  String durationValue = '15:00';
  int walkOrJogIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OutrNavigationBar(),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Cardio'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body:  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 25, 25, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                height: 270.0,
                width: 330.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(110, 80, 110, 0),
              child: Row(
                children: <Widget>[
                  //Icon or text here -------------------------
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 15.0,
                    activeBgColors: [[Color.fromARGB(255, 43, 121, 255)], [Color.fromARGB(255, 43, 121, 255)]],
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
                      print(walkOrJogIndex);
                    },
                  ),
                  //Icon or text here ----------------------------
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(135, 130, 135, 0),
              child: Text('Duration:',
                  style: TextStyle(fontFamily: "Dongle", fontSize: 50)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(165, 185, 165, 0),
              child: DecoratedBox(
                  decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.black),

                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                    child: DropdownButton<String>(
                      value: durationValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          durationValue = newValue!;
                        });
                      },
                      underline: SizedBox(),
                      items: <String>['15:00', '20:00','25:00', '30:00', '35:00', '40:00', '45:00', '50:00', '55:00', '60:00']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
              ),
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(90, 320, 80, 0),
                child: SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 43, 121, 255)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        )
                    ),
                    onPressed: () {},
                    child: Text(
                        'Select',
                        style: TextStyle(
                            fontFamily: "Dongle",
                            fontSize: 50
                        )
                    ),
                  ),
                )

            )
          ],
        ),
      ),
    );
  }
}