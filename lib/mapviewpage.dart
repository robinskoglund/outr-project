import 'package:flutter/material.dart';

class MapViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outr Demo'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/greenbackgroundtest.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250.0, horizontal: 135.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    icon: const Icon(
                        Icons.arrow_back
                    ),
                    label: const Text('Back')
                ),
              ]
          ),
        ),
      ),
    );
  }
}