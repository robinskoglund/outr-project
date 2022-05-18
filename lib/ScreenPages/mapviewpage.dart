import 'dart:collection';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../API/directions_model.dart';
import '../API/httprequesthandler.dart';
import '../Components/navigationbar.dart';
import '../Components/slidingupwidget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String route = '';
  int buttonSelection = 0;
  final slidingUpPanelController = PanelController();
  final CameraPosition _initialCameraPosition = const CameraPosition(target: LatLng(59.330668, 18.056498), zoom: 11.5,);
  late GoogleMapController _googleMapController;
  Directions? _info;
  late Position geoPosition;
  Set<Marker> _markers = HashSet<Marker>();
  late BitmapDescriptor _markerIcon;
  String gymName = '';
  double gymLat = 0;
  double gymLong = 0;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _setGymMarkerIcon();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _setGymMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/barbell.png');
  }

  bool _isShow = true;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    final slidingUpPanelHeightCollapsed = MediaQuery.of(context).size.height * 0.14;
    final slidingUpPanelHeightOpened = MediaQuery.of(context).size.height * 0.8;

    return Scaffold(
      endDrawer: OutrNavigationBar(),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Outr Map'),
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
              panelController: slidingUpPanelController,
              chooseButton: (int buttonNumber) {
                setState(() {
                  buttonSelection = buttonNumber;
                  chooseButton(buttonSelection);
                });
              },
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
          ),

          Stack(
            children: <Widget>[
              Visibility(
                visible: _isShow,
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
                  onPressed: (){
                    setState(
                            () {
                              buttonSelection = 1;
                              chooseButton(1);
                              _isShow = !_isShow;
                        });
                  },
                  child: const Text(
                    'Yes please!',
                    style: TextStyle(fontFamily: 'Dongle', color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
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
                  onPressed: (){
                    setState(
                            () {
                              _isShow = !_isShow;
                        });
                  },
                  child: const Text(
                    'No thanks!',
                    style: TextStyle(fontFamily: 'Dongle', color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void chooseButton(int selection) async{
    if (buttonSelection != 0) {
      if (buttonSelection == 1) {
        _markers.clear();
        route =
        await HttpRequestHandler().getStrengthRoute(59.331739, 18.060259);
        await populateInfo();
      }
      if (buttonSelection == 2) {
        _markers.clear();
        route =
        await HttpRequestHandler().getCardioRoute(59.331739, 18.060259, 20, 8);
        await populateInfo();
      }
      if (buttonSelection == 3) {
        _markers.clear();
        route =
        await HttpRequestHandler().getStrengthRoute(59.331739, 18.060259);
        await populateInfo();
      }
      if (buttonSelection == 4) {
        _markers.clear();
        route =
        await HttpRequestHandler().getMixRoute(59.331739, 18.060259, 20, 8);
        await populateInfo();
      }
    }
  }

  Future<Void> populateInfo() async {
    String tempRoute = route;
    List routeString = tempRoute.split('-');

    HttpRequestHandler().getRoute();
    final directions = await HttpRequestHandler()
        .getDirections(routeString[0]);
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

      if(buttonSelection == 1 || buttonSelection == 3 || buttonSelection == 4) {
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