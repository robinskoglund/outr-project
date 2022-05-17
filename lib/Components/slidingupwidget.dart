import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpWidget extends StatelessWidget{
  final PanelController panelController;

  const SlidingUpWidget({
    Key? key,
    required this.panelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      SizedBox(height: 15),
      openUpPanelDragHandle(),

      Center(
        child: ElevatedButton(
          onPressed: () {togglePanelUpDown();},
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(390, 30)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(0),
          ), child: const Text(
          'Start',
          style: TextStyle(
            fontSize: 60.0,
            letterSpacing: 1.5,
            color: Colors.blueGrey,
            fontFamily: 'Dongle',
          ),
        ),
        ),
      ),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 80,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: (){},
              icon: Image.asset('assets/plainDude.png'),
              label: Text('Beginner Program'),
              extendedTextStyle: TextStyle(fontFamily: 'Dongle', fontSize: 50),
            ),
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 80,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: (){},
              icon: Image.asset('assets/cardioDude.png'),
              label: Text('Cardio'),
              extendedTextStyle: TextStyle(fontFamily: 'Dongle', fontSize: 50),
            ),
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 80,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: (){},
              icon: Image.asset('assets/strengthDude.png'),
              label: Text('Strength'),
              extendedTextStyle: TextStyle(fontFamily: 'Dongle', fontSize: 50),
            ),
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 80,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: (){},
              icon: Image.asset('assets/mixDude.png'),
              label: Text('Mix'),
              extendedTextStyle: TextStyle(fontFamily: 'Dongle', fontSize: 50),
            ),
          ),
        ),
      ),

    ],
  );

  Widget openUpPanelDragHandle() => GestureDetector(
    child: Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    onTap: togglePanelUpDown,
  );

  //Den här skiten funkar ju bara när den är nere
  void togglePanelUpDown() => panelController.isPanelOpen ? panelController.close() : panelController.open();

}