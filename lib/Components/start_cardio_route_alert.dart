import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ScreenPages/mapview_page.dart';

//Instansieras så här:
// Visibility(
// visible: isVisible,
// child: ShowAlertBeforeCardioRoute(1, 10)
// ),

class ShowAlertBeforeCardioRoute extends StatelessWidget {
  final int walkOrRunInt, minutes;

  ShowAlertBeforeCardioRoute(this.walkOrRunInt, this.minutes);

  //Popup som kommer när rutt har genererats som inkluderar refresh button för att skapa ny rutt
  //samt lite information om rutten
  @override
  Widget build(BuildContext context) {
    String walkOrRunString;
    if (walkOrRunInt == 1)
      walkOrRunString = 'Run:';
    else
      walkOrRunString = 'Walk:';

    return Stack(children: <Widget>[
      ElevatedButton.icon(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
                Size.fromHeight(50)),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.deepOrangeAccent,
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            )),
        icon: Icon(Icons.refresh_rounded,
            size: 50, color: Colors.black),
        label: Text(
            'Not happy with the route? \n'
                'Press to generate a new route',
            style: TextStyle(
                fontFamily: 'Dongle',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 2)),
        onPressed: () {
          // TODO Sätt in slumpa ny rutt
        },
      ),
      Center(
        child: Container(
          height: 250,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  '$walkOrRunString',
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.timer_outlined,
                      color: Colors.black,
                      size: 20.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '$walkOrRunInt minutes*',
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
                  height: 50,
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
                  },
                  child: Text(
                    'Start route',
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
        ),
      ),
    ]);
  }
}