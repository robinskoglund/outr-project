import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'directions_model.dart';
import 'geopositionpage.dart';
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
  GoogleMapController? _controller;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(59.330668, 18.056498),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  Directions? _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
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
        //markers: {}
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
        _populateInfo();
      },
      ),

    );
  }


  void _populateInfo() async {
    final directions = await HttpRequestHandler()
        .getDirections();
    setState(() => _info = directions);
  }
}