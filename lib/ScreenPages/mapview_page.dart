import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:outr/Components/aler_before_beginner_program.dart';
import 'package:outr/Components/gubbis.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../API/directions_model.dart';
import '../API/httprequesthandler.dart';
import '../Components/cardio_choices_popup.dart';
import '../Components/mix_choices_popup.dart';
import '../Components/navigation_bar.dart';
import '../DataClasses/userdata.dart';
import 'finished_gym_workout.dart';

class MapScreen extends StatefulWidget {
  final User user;
  final bool showPopUp;

  const MapScreen({Key? key, required this.user, required this.showPopUp})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String route = '';
  int buttonSelection = 0;
  final slidingUpPanelController = PanelController();
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(59.330668, 18.056498),
    zoom: 11.5,
  );
  late GoogleMapController _googleMapController;
  Directions? _info;
  late Position geoPosition;
  Set<Marker> _markers = HashSet<Marker>();
  late BitmapDescriptor _markerIcon;
  late BitmapDescriptor _geoDudeIcon;
  String gymName = '';
  double gymLat = 0;
  double gymLong = 0;
  bool avatarPopUp = true;
  String durationValue = '15';
  bool cardioPopup = false;
  bool mixPopup = false;
  bool _beginnerPopup = false;
  bool _isShow = false;
  bool _refreshRouteShow = false;
  String walkOrRunString = 'Walk';
  String distance = '0:00';
  int speed = 0;

  bool _endWorkout = false;
  bool _isActive = false;
  bool _isPaused = false;
  String _playPause = 'Play';
  String _sliderHeader = 'Start';
  Stopwatch _watch = Stopwatch();
  late Timer _timer;
  bool _startStop = true;
  bool _click = false;
  String _elapsedTime = '00:00';
  String arrivalDuration = '0:00';

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _setMarkerIcons();
    if (widget.showPopUp == true) {
      avatarPopUp = true;
    } else {
      avatarPopUp = false;
    }
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _setMarkerIcons() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/barbell.png');
    _geoDudeIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/geodude.png');
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    final slidingUpPanelHeightCollapsed =
        MediaQuery.of(context).size.height * 0.14;
    final slidingUpPanelHeightOpened = MediaQuery.of(context).size.height * 0.8;

    return Scaffold(
      endDrawer: OutrNavigationBar(widget.user),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.local_fire_department,
              color: Colors.orange,
              size: 30,
            ),
            Text(widget.user.dailyStreak.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontFamily: "Dongle",
                  fontSize: 28,
                )),
            const SizedBox(width: 20),
            const Text('XP',
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontFamily: "Dongle",
                    fontSize: 40)),
            Text(widget.user.xp.toString(),
                style: const TextStyle(
                    color: Colors.black54, fontFamily: "Dongle", fontSize: 28)),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.hybrid,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: _markers,
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                )
            },
          ),
          SlidingUpPanel(
            controller: slidingUpPanelController,
            minHeight: slidingUpPanelHeightCollapsed,
            maxHeight: slidingUpPanelHeightOpened,
            panelBuilder: (controller) => slidingUpWidget(),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20.0)),
          ),

          Visibility(
            child: AlertBeforeBeginnerProgram(
              updateAlertBeforeBeginner: _updateAlertBeforeBeginner
          ),
            visible: _beginnerPopup,
          ),

          Visibility(
            visible: _isShow,
            child: Stack(children: <Widget>[
              Visibility(
                visible: _refreshRouteShow,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size.fromHeight(50)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepOrangeAccent,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.transparent,
                      )),
                  icon: Icon(Icons.refresh_rounded,
                      size: 40, color: Colors.black),
                  label: const Text(
                      'Not happy with the route? \n'
                      'Press to generate a new route',
                      style: TextStyle(
                          fontFamily: 'Dongle',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2)),
                  onPressed: () {
                    generateNewRoute(buttonSelection);
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 180),
                  child: Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '$walkOrRunString',
                            style: const TextStyle(
                              fontFamily: 'Dongle',
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon((buttonSelection == 3) ?
                                Icons.directions_walk : Icons.timer_outlined,
                                color: Colors.black,
                                size: 20.0,
                              ),
                              const SizedBox(width: 2.0),
                              Text(() {
                                if (buttonSelection == 3) {
                                  return '$distance away.';
                                }
                                return '$durationValue minutes*';
                              }(),
                                style: const TextStyle(
                                fontFamily: 'Dongle',
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            ],
                          ),
                          const Text(
                            '*This is only an estimate, take it at your own pace',
                            style: TextStyle(
                              fontFamily: 'Dongle',
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            //TODO: implement direction to start route
                            onPressed: () {
                              setState(() {
                                _isShow = false;
                                setPlayPause();
                                startOrStop();
                              });
                            },
                            child: const Text(
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
              ),
            ]),
          ),

          Visibility(
            visible: avatarPopUp,
              child: Gubbis(updateIsAvatar: _updateAvatarPopup,
              buttonSelectionOne: chooseButton,
                updateAlertBeforeBeginner: _updateAlertBeforeBeginner,
              ),
          ),

          Visibility(
            visible: cardioPopup,
            child: CardioChoices(
              dataCallback: (duration, walkOrRun, popUp, isShow, kmPerHour) {
                setState(() {
                  durationValue = duration;
                  walkOrRunString = walkOrRun;
                  cardioPopup = popUp;
                  _isShow = isShow;
                  speed = kmPerHour;
                });
              },
              functionCallback: (isCardio) {
                getAndShowCardioOrMixRoute(isCardio);
              },
            ),
          ),
          Visibility(
            visible: mixPopup,
            child: MixChoices(
              dataCallback: (duration, walkOrRun, popUp, isShow, kmPerHour) {
                setState(() {
                  durationValue = duration;
                  walkOrRunString = walkOrRun;
                  mixPopup = popUp;
                  _isShow = isShow;
                  speed = kmPerHour;
                });
              },
              functionCallback: (isCardio) {
                getAndShowCardioOrMixRoute(isCardio);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget slidingUpWidget(){
    return ListView(
      physics: NeverScrollableScrollPhysics(),
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
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.white),
                elevation: MaterialStateProperty.all<double>(0),
              ),
              child: Stack(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Visibility(
                        visible: !_isActive,
                        child: Text(
                          _sliderHeader,
                          style: const TextStyle(
                            fontSize: 60.0,
                            letterSpacing: 1.5,
                            color: Colors.blueGrey,
                            fontFamily: 'Dongle',
                          ),
                        ),
                      ),
                      Visibility(
                          visible: _isActive,
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(_elapsedTime,
                                      style: const TextStyle(
                                          fontFamily: 'Dongle',
                                          fontSize: 50,
                                          color: Colors.black)),
                                  Text(distance,
                                      style: const TextStyle(
                                          fontFamily: 'Dongle',
                                          fontSize: 50,
                                          color: Colors.black)),
                                  Text(arrivalDuration,
                                      style: const TextStyle(
                                          fontFamily: 'Dongle',
                                          fontSize: 50,
                                          color: Colors.black)),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Text("Min",
                                        style: TextStyle(
                                            fontFamily: 'Dongle',
                                            fontSize: 30,
                                            color: Colors.black)),
                                    Text("      KM",
                                        style: TextStyle(
                                            fontFamily: 'Dongle',
                                            fontSize: 30,
                                            color: Colors.black)),
                                    Text("Arrival",
                                        style: TextStyle(
                                            fontFamily: 'Dongle',
                                            fontSize: 30,
                                            color: Colors.black)),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  )
                ],
              )),
        ),
        Visibility(
          visible: !_isActive,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
                child: Container(
                  width: 300,
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.black,
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            )),
                        icon: Image.asset('assets/cardioDude.png'),
                        label: const Text('Cardio',
                            style: TextStyle(
                                fontFamily: 'Dongle', fontSize: 50)),
                        onPressed: () {
                          changeState();
                          chooseButton(2);
                          setState(() {
                            buttonSelection = 2;
                          });
                          slidingUpPanelController.close();
                        },
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.black,
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            )),
                        icon: Image.asset('assets/strengthDude.png'),
                        label: const Text('Strength',
                            style: TextStyle(
                                fontFamily: 'Dongle', fontSize: 50)),
                        onPressed: () {
                          changeState();
                          chooseButton(3);
                          setState(() {
                            buttonSelection = 3;
                          });
                          slidingUpPanelController.close();
                        },
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.black,
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            )),
                        icon: Image.asset('assets/mixDude.png'),
                        label: const Text('Mix',
                            style: TextStyle(
                                fontFamily: 'Dongle', fontSize: 50)),
                        onPressed: () {
                          changeState();
                          chooseButton(4);
                          setState(() {
                            buttonSelection = 4;
                          });
                          slidingUpPanelController.close();
                        },
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
                              children: const <Widget>[
                                Text(
                                  "0,00",
                                  style: TextStyle(
                                    fontSize: 60.0,
                                    letterSpacing: 1.5,
                                    color: Colors.black,
                                    fontFamily: 'Dongle',
                                  ),
                                ),
                                Text("0,00",
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
                              children: const <Widget>[
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
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.black,
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            )),
                        icon: Icon(
                            (_isPaused == false)
                                ? Icons.play_arrow
                                : Icons.pause_circle,
                            size: 40),
                        label: Text(_playPause,
                            style: const TextStyle(
                                fontFamily: 'Dongle', fontSize: 50)),
                        onPressed: () {
                          togglePanelUpDown();
                          setState(() {
                            setPlayPause();
                            startOrStop();
                          });
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white,
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            )),
                        child: const Text('End',
                            style: TextStyle(
                                fontFamily: 'Dongle', fontSize: 50)),
                        onPressed: () {
                          endWorkoutDialog(context);
                        },
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
  }

  //Function that I wanna use at MixChoices/CardioChoices callback
  void getAndShowCardioOrMixRoute(bool getAndShowCardio) async{
    if(getAndShowCardio) {
      _refreshRouteShow = true;
      _markers.clear();
      route = await HttpRequestHandler().getCardioRoute(59.331739,
          18.060259, int.parse(durationValue), speed);
      populateInfo();
    }else{
      _refreshRouteShow = true;
      _markers.clear();
      route = await HttpRequestHandler().getMixRoute(59.331739,
          18.060259, int.parse(durationValue), speed);
      populateInfo();
    }
  }

  void generateNewRoute(int selection) async {
    switch (selection) {
      case 1:
        route =
            await HttpRequestHandler().getStrengthRoute(59.331739, 18.060259);
        populateInfo();
        break;

      case 2:
        route = await HttpRequestHandler()
            .getCardioRoute(59.331739, 18.060259, int.parse(durationValue), 5);
        populateInfo();
        break;

      case 3:
        route =
            await HttpRequestHandler().getStrengthRoute(59.331739, 18.060259);
        populateInfo();
        break;

      case 4:
        route =
            await HttpRequestHandler().getMixRoute(59.331739, 18.060259, 5, 5);
        populateInfo();
        break;
    }
  }

  void chooseButton(int selection) async {
    if (selection != 0) {
      //Executes when clicking Cardio button
      if (selection == 2) {
        cardioPopup = true;
      }
      //Executes when clicking Strength button
      if (selection == 3) {
        route =
        await HttpRequestHandler().getStrengthRoute(59.331739, 18.060259);
        populateInfo();
        setState(() {
          walkOrRunString = 'Nearest gym is';
        });
        _isShow = true;
        _refreshRouteShow = false;
      }
      //Mix choices popup
      if (selection == 4) {
        mixPopup = true;
      }
      if (selection == 5) {
        _markers.clear();
        _info = null;
      }
      if (selection == 6) {
        _isShow = false;
      }
    }
  }

  void populateInfo() async {
    String tempRoute = route;
    List routeString = tempRoute.split('-');

    HttpRequestHandler().getRoute();
    final directions = await HttpRequestHandler().getDirections(routeString[0]);
    setState(() {
      _info = directions;
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(geoPosition.latitude, geoPosition.longitude),
          infoWindow: const InfoWindow(
            title: 'My Position',
            snippet: 'My current position',
          ),
          icon: _geoDudeIcon,
        ),
      );

      if (buttonSelection == 1 || buttonSelection == 3 || buttonSelection == 4) {
        //Populates the stateful gym name and lat longs.
        setGymInformation();
        //Sets up meters as distance
        distance = _info!.totalDistance;
        arrivalDuration = _info!.totalDuration;
        //Sets the gym marker icon
        _setMarkerIcons();
        _markers.add(
          Marker(
            markerId: const MarkerId("1"),
            position: LatLng(gymLat, gymLong),
            infoWindow: InfoWindow(
              title: gymName,
              snippet: 'Gym location of ' + gymName,
            ),
            icon: _markerIcon,
          ),
        );
      }
    });
  }

  //Get location for showing geo location marker on map
  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    var locatePosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      geoPosition = locatePosition;
    });
  }

  //update the gym information based on the get request from pathfinder, after the "-"
  void setGymInformation() {
    String tempRoute = route;
    List routeString = tempRoute.split('-');
    List routeString2 = routeString[1].split('|');
    setState(() {
      gymName = routeString2[0];
      gymLat = double.parse(routeString2[1]);
      gymLong = double.parse(routeString2[2]);
    });
  }

  void _updateAlertBeforeBeginner(bool isVisible){
    setState(() {
      _beginnerPopup = !_beginnerPopup;
    });
  }
  void _updateAvatarPopup(bool isVisible){
    setState(() {
      avatarPopUp = !avatarPopUp;
    });
  }

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

  void endWorkout(bool endWorkout) { //om man vill avsluta så körs denna metod
    if(endWorkout == true) {
      stopWatch();
      resetTimer();
      _isPaused = false;
      _playPause = "Play";
      buttonSelection = 5;
      slidingUpPanelController.close();
    }
  }

  void endWorkoutDialog(BuildContext context) {
    var alert = AlertDialog(
      title: const Text("End workout",
          style: TextStyle(fontFamily: "Dongle", fontSize: 40)),
      content: const Text("Do you wish to end your current workout?",
          style: TextStyle(fontFamily: "Dongle", fontSize: 25)),
      actions: <Widget>[
        TextButton(onPressed: () {
          Navigator.of(context).pop();
          _endWorkout = false; //sätter att man vill avsluta till false
        },
          child: const Text("Cancel", style: TextStyle(color: Colors.black,
              fontFamily: 'Dongle', fontSize: 30),),
        ),
        const SizedBox(width: 5.0),


        TextButton(onPressed: () {
          _endWorkout = true;  //sätter att man vill avsluta till ja
          endWorkout(_endWorkout);
          Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => //skickar användaren
          //till FinishedGymWorkout sidan
          FinishedGymWorkoutPage(widget.user)));
        },
          child: const Text("End", style: TextStyle(color: Colors.red,
              fontFamily: 'Dongle', fontSize: 30),),
        ),
        const SizedBox(width: 5.0),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
    //visar alerten
  }

  void changeState() {
    setState(() {
      if (!_isActive) {
        _isActive = true;
      } else {
        _isActive = false;
      }
    });
  }

  void togglePanelUpDown() => slidingUpPanelController.isPanelOpen
      ? slidingUpPanelController.close()
      : slidingUpPanelController.open();

  void setPlayPause () {
    if (_isPaused) {
      _playPause = 'Play';

    } else {
      _playPause = 'Pause';
    }
    _isPaused = !_isPaused;
  }

  startOrStop() {
    if (_startStop) {
      _click = true;
      startWatch();
    } else {
      stopWatch();
    }
  }

  resetTimer() {
    _watch.reset();
    _elapsedTime = "00:00";
  }

  startWatch() {
    setState(() {
      _startStop = false;
      _watch.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      _click = false;
      _startStop = true;
      _watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = _watch.elapsedMilliseconds;
    setState(() {
      _elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    // int hours = (minutes / 60).truncate();

    // String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  updateTime(Timer timer) {
    if (_watch.isRunning) {
      setState(() {
        _elapsedTime = transformMilliSeconds(_watch.elapsedMilliseconds);
      });
    }
  }
}
