import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'directions_model.dart';
import 'geopositionpage.dart';
import 'package:geolocator/geolocator.dart';
import 'httprequesthandler.dart';

/*
TODO: Fixa så _addGeoLocMarker och _addGymMarker används och skapar markers.
TODO: Se över markings, göra till en metod? De måste göras async och kalla på getDirections() i den. (Get Directions Info på yt)
 */

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Outr Map'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: GoogleMap(
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
      floatingActionButton: FloatingActionButton(onPressed: () {
        //_populateInfo();
        testPopulate();
        _setGymMarkerIcon();
      },
      ),

    );
  }

  void _populateInfo() async {
    final directions = await HttpRequestHandler()
        .getDirections();
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

      //Gym marker, switch lat and longs for gymLat and gymLong
      _markers.add(
        Marker(
        markerId: MarkerId("1"),
        position: LatLng(37.421817, -122.083691),
        infoWindow: InfoWindow(
          title: gymName,
          snippet: 'Gym location of' + gymName,
        ),
          icon: _markerIcon,
      ),
      );
    });
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
    String temp = HttpRequestHandler().getStringFromPathfinder(false) as String;
    temp.split('|');
    setState(() {
      gymName = temp[0];
      gymLat = double.parse(temp[1]);
      gymLong = double.parse(temp[2]);
    });
  }

  //Temporary test marker method, since the get request from pathfinder isnt fully functional yet
  void testPopulate() {
    setState(() {
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

      //Gym marker, switch lat and longs for gymLat and gymLong
      _markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(37.421817, -122.083691),
          infoWindow: InfoWindow(
            title: gymName,
            snippet: 'Gym location of' + gymName,
          ),
          icon: _markerIcon,
        ),
      );
    });
  }

}