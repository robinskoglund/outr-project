import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outr/DataClasses/userdata.dart';
import '../Components/navigation_bar.dart';
import 'mapview_page.dart';


class FinishedGymWorkoutPage extends StatelessWidget {
  final User user;

  FinishedGymWorkoutPage(this.user, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: OutrNavigationBar(user),
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text('Finished Workout',
              style: TextStyle(fontFamily: "Dongle",
                  fontSize: 45)),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),

        body: Column(
          children: <Widget>[
            TextFormField(
              textAlign: TextAlign.center,
              initialValue: 'Farsta Utegym',
              style: TextStyle(
                fontFamily: 'Dongle',
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '31:20',
                      style: TextStyle(
                        fontFamily: 'Dongle',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Minutes',
                      style: TextStyle(
                        fontFamily: 'Dongle',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapScreen(showPopUp: false, user: user)),
                    );
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 34,
                      color: Colors.red,
                    ),
                  ),
                ),



                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {}, //lägg till så rutten sparas
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 34,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}