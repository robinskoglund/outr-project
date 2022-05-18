import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../ScreenPages/mapviewpage.dart';

class SlidingUpWidget extends StatefulWidget {
  final PanelController panelController;
  final ButtonChoiceCallback chooseButton;

  const SlidingUpWidget({
    Key? key,
    required this.panelController,
    required this.chooseButton,
  }) : super(key: key);

  @override
  State<SlidingUpWidget> createState() => _SlidingUpWidgetState();
}

class _SlidingUpWidgetState extends State<SlidingUpWidget> {
  bool _isActive = false;
  bool _isPaused = false;
  String _playPause = "Pause";
  String _sliderHeader = 'Start';

  //TODO: Testa att lägga Center utanför som en stateful?
  //TODO: Testa att

  @override
  Widget build(BuildContext context) => ListView(
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
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                elevation: MaterialStateProperty.all<double>(0),
              ),
              child: Text(
                _sliderHeader,
                style: TextStyle(
                  fontSize: 60.0,
                  letterSpacing: 1.5,
                  color: Colors.blueGrey,
                  fontFamily: 'Dongle',
                ),
              ),
            ),
          ),
          Visibility(
            visible: !_isActive,
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
                        FloatingActionButton.extended(
                          heroTag: 'beginnerbutton',
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          onPressed: () {
                            togglePanelUpDown();
                            // widget.chooseButton(1);
                            changeState();
                          },
                          icon: Image.asset('assets/plainDude.png'),
                          label: Text('Beginner Program'),
                          extendedTextStyle:
                              TextStyle(fontFamily: 'Dongle', fontSize: 50),
                        ),
                        FloatingActionButton.extended(
                          heroTag: 'cardiobutton',
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          onPressed: () {
                            togglePanelUpDown();
                            // widget.chooseButton(2);
                            changeState();
                          },
                          icon: Image.asset('assets/cardioDude.png'),
                          label: Text('Cardio'),
                          extendedTextStyle:
                              TextStyle(fontFamily: 'Dongle', fontSize: 50),
                        ),
                        FloatingActionButton.extended(
                          heroTag: 'strengthbutton',
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          onPressed: () {
                            togglePanelUpDown();
                            // widget.chooseButton(3);
                            changeState();
                          },
                          icon: Image.asset('assets/strengthDude.png'),
                          label: Text('Strength'),
                          extendedTextStyle:
                              TextStyle(fontFamily: 'Dongle', fontSize: 50),
                        ),
                        FloatingActionButton.extended(
                          heroTag: 'mixbutton',
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          onPressed: () {
                            togglePanelUpDown();
                            // widget.chooseButton(4);
                            changeState();
                          },
                          icon: Image.asset('assets/mixDude.png'),
                          label: Text('Mix'),
                          extendedTextStyle:
                              TextStyle(fontFamily: 'Dongle', fontSize: 50),
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
                                children: <Widget>[
                                  Text(
                                    "0,60",
                                    style: TextStyle(
                                      fontSize: 60.0,
                                      letterSpacing: 1.5,
                                      color: Colors.black,
                                      fontFamily: 'Dongle',
                                    ),
                                  ),
                                  Text("12,47",
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
                                children: <Widget>[
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
                        FloatingActionButton.extended(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          onPressed: () {
                            togglePanelUpDown();
                            setState(() {
                              if (_playPause == 'Pause') {
                                _playPause = 'Play';
                              } else {
                                _playPause = "Pause";
                              }
                              _isPaused = !_isPaused;
                            });
                          },
                          icon: Icon((_isPaused == false) ? Icons.pause_circle : Icons.play_arrow, size: 40),
                          label: Text(_playPause),
                          extendedTextStyle:
                              TextStyle(fontFamily: 'Dongle', fontSize: 50),
                        ),
                        FloatingActionButton.extended(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.black,
                          onPressed: () {
                            changeState();
                            togglePanelUpDown();
                          },
                          label: Text('End'),
                          extendedTextStyle: TextStyle(
                              fontFamily: 'Dongle',
                              fontSize: 50,
                              color: Colors.white),
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

  void changeState() {
    setState(() {
      if (!_isActive) {
        _isActive = true;
        _sliderHeader = '31:00' + '   ' + '2,02' + '    ' + '7:00';
      } else {
        _isActive = false;
        _sliderHeader = 'Start';
      }
    });
  }

  //Den här skiten funkar ju bara när den är nere
  void togglePanelUpDown() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();
}

typedef ButtonChoiceCallback = void Function(int buttonNumber);
