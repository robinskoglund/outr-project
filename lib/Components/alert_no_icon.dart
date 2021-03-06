import 'package:flutter/material.dart';

//Kan anropas så här:
// onPressed: () {
// showDialog(context: context,
// builder: (BuildContext context){
// return AlertNoIcon('Alert', 'hejhejhejhejhejalert', 'Cancel', 'Abort');},);},

class AlertNoIcon extends StatelessWidget{

  final title, content, leftButtonText, rightButtonText;

  AlertNoIcon(this.title, this.content, this.leftButtonText, this.rightButtonText);

  @override
  Widget build(BuildContext context){

    //Hjälpklass för att kunna skapa enkla alerts
    return AlertDialog(
      title: Text(title, style: TextStyle(fontFamily: 'Dongle', fontSize: 30),),
      content: Text(content, style: TextStyle(fontFamily: 'Dongle', fontSize: 25),),
      actions: <Widget>[
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        },
          child: Text(leftButtonText, style: TextStyle(color: Colors.black, fontFamily: 'Dongle', fontSize: 30),),
        ),
        SizedBox(width: 5.0),
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        },
          child: Text(rightButtonText, style: TextStyle(color: Colors.red, fontFamily: 'Dongle', fontSize: 30),),
        ),
      ],
    );
  }
}