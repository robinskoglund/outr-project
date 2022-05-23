import 'dart:collection';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../API/directions_model.dart';
import '../API/httprequesthandler.dart';
import '../Components/navigation_bar.dart';
import '../Components/outr_icons_icons.dart';
import '../Components/sliding_up_widget.dart';
import '../DataClasses/userdata.dart';

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
  String gymName = '';
  double gymLat = 0;
  double gymLong = 0;
  bool avatarPopUp = true;
  String durationValue = '15';
  int walkOrJogIndex = 0;
  bool cardioPopup = false;
  bool mixPopup = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _setGymMarkerIcon();
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

  void _setGymMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/barbell.png');
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
        title: const Text('OutR Map'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
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
            panelBuilder: (controller) => SlidingUpWidget(
              user: widget.user,
              panelController: slidingUpPanelController,
              chooseButton: (int buttonNumber) {
                setState(() {
                  buttonSelection = buttonNumber;
                  chooseButton(buttonSelection);
                });
              },
            ),
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          beginnerPopUpStack(),
          cardioChoicesContainer(),
          mixChoicesContainer(),
        ],
      ),
    );
  }

  Widget cardioChoicesContainer(){
    return Visibility(
      visible: cardioPopup,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 25, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                  ),
                  height: 380.0,
                  width: 350.0,
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
                      activeBgColors: [
                        [Color.fromARGB(255, 43, 121, 255)],
                        [Color.fromARGB(255, 43, 121, 255)]
                      ],
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
                  padding: const EdgeInsets.fromLTRB(170, 185, 100, 0),
                  child: Row(
                    children: <Widget>[
                      DecoratedBox(
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.black),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0)),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0.0),
                            child: DropdownButton<String>(
                              value: durationValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  durationValue = newValue!;
                                });
                              },
                              underline: SizedBox(),
                              items: <String>[
                                '15',
                                '20',
                                '25',
                                '30',
                                '35',
                                '40',
                                '45',
                                '50',
                                '55',
                                '60'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )),
                      Text('  min',
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 280, 80, 0),
                child: SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 43, 121, 255)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ))),
                    onPressed: () async {
                      setState(() {
                        cardioPopup = false;
                      });
                      int speed = 0;
                      if(walkOrJogIndex == 0){
                        speed = 5;
                      }else{
                        speed = 8;
                      }
                      _markers.clear();
                      route =
                      await HttpRequestHandler().getCardioRoute(59.331739, 18.060259, int.parse(durationValue), speed);
                      await populateInfo();
                    },
                    child: Text('Select',
                        style: TextStyle(
                            fontFamily: "Dongle", fontSize: 50)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(310, 40, 40, 0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cardioPopup = false;
                    });
                  },
                  child: Icon(Icons.clear),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[400],
                    onPrimary: Colors.black,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mixChoicesContainer(){
    return Visibility(
      visible: mixPopup,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 25, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                  ),
                  height: 380.0,
                  width: 350.0,
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
                      activeBgColors: [
                        [Color.fromARGB(255, 43, 121, 255)],
                        [Color.fromARGB(255, 43, 121, 255)]
                      ],
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
                          print(walkOrJogIndex);
                        });
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
                  padding: const EdgeInsets.fromLTRB(170, 185, 100, 0),
                  child: Row(
                    children: <Widget>[
                      DecoratedBox(
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.black),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0)),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0.0),
                            child: DropdownButton<String>(
                              value: durationValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  durationValue = newValue!;
                                });
                              },
                              underline: SizedBox(),
                              items: <String>[
                                '15',
                                '20',
                                '25',
                                '30',
                                '35',
                                '40',
                                '45',
                                '50',
                                '55',
                                '60'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )),
                      Text('  min',
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 280, 80, 0),
                child: SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 43, 121, 255)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ))),
                    onPressed: () async {
                      setState(() {
                        mixPopup = false;
                      });
                      int speed = 0;
                      if(walkOrJogIndex == 0){
                        speed = 5;
                      }else{
                        speed = 8;
                      }
                      _markers.clear();
                      route =
                      await HttpRequestHandler().getMixRoute(59.331739, 18.060259, int.parse(durationValue), speed);
                      await populateInfo();
                    },
                    child: Text('Select',
                        style: TextStyle(
                            fontFamily: "Dongle", fontSize: 50)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(310, 40, 40, 0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      mixPopup = false;
                    });
                  },
                  child: Icon(Icons.clear),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[400],
                    onPrimary: Colors.black,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget beginnerPopUpStack() {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: avatarPopUp,
          child: Image.asset('assets/cropedgubbis.png'),
        ),
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
              setState(() {
                buttonSelection = 1;
                chooseButton(1);
                avatarPopUp = !avatarPopUp;
              });
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
              setState(() {
                avatarPopUp = !avatarPopUp;
              });
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

  void chooseButton(int selection) async {
    if (buttonSelection != 0) {

      //Executes when clicking Beginner button
      if (buttonSelection == 1) {
        _markers.clear();
        route =
        await HttpRequestHandler().getStrengthRoute(59.331739, 18.060259);
        await populateInfo();
      }

      //Executes when clicking Cardio button
      if (buttonSelection == 2) {
        cardioPopup = true;
      }

      //Executes when clicking Strength button
      if (buttonSelection == 3) {
        _markers.clear();
        route =
        await HttpRequestHandler().getStrengthRoute(59.331739, 18.060259);
        await populateInfo();
      }

      //Mix choices popup
      if (buttonSelection == 4) {
        mixPopup = true;
      }

      if (buttonSelection == 5) {
        _markers.clear();
        _info = null;
      }
    }
  }

  Future<Void> populateInfo() async {
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
          infoWindow: InfoWindow(
            title: 'My Position',
            snippet: 'My current position',
          ),
        ),
      );

      if (buttonSelection == 1 ||
          buttonSelection == 3 ||
          buttonSelection == 4) {
        //Puts the gym into local variables
        setGymInformation();
        //Sets the gym marker icon
        _setGymMarkerIcon();
        _markers.add(
          Marker(
            markerId: MarkerId("1"),
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
    return Future.delayed(const Duration(seconds: 2));
  }

  //Get location for showing geo location marker on map
  getCurrentLocation() async {
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
}