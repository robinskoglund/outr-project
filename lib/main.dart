import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text('Outr Demo'),
      centerTitle: true,
    ),
    body: Center(
      child: Text('Outr demo test'),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {  },
      child: Text('click'),
    ),
  ),
));
