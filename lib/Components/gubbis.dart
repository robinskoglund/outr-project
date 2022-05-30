import 'package:flutter/material.dart';

class Gubbis extends StatelessWidget {
  final ValueChanged<bool> updateIsAvatar;
  final ValueChanged<bool> updateAlertBeforeBeginner;
  final ChoicesCallback dataCallback;

  Gubbis({required this.dataCallback,
    required this.updateIsAvatar,
  required this.updateAlertBeforeBeginner});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset('assets/cropedgubbis.png'),
        Positioned(
          top: 190,
            right: 160,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black),
              ),
            ),
            onPressed: () {
              dataCallback(5, 1);
              updateIsAvatar(false);
              updateAlertBeforeBeginner(false);
            },
            child: const Text(
              'Yes please!',
              style: TextStyle(
                  fontFamily: 'Dongle',
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 190,
          left: 220,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black),
              ),
            ),
            onPressed: () {
              updateIsAvatar(false);
            },
            child: const Text(
              'No thanks!',
              style: TextStyle(
                  fontFamily: 'Dongle',
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

typedef ChoicesCallback = void Function(double introductionSpeed, int buttonChoice);