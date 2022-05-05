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
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  Directions? _info;
  late Marker _origin;
  late Marker _gym;

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
        //markers: {},
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
        _testJsonOnMap();
      },

      ),
    );
  }

  void _addGeoLocMarker(LatLng pos) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('Start point'),

          //Vad som visas när man klickar på marker
          infoWindow: const InfoWindow(title: 'Start point'),

          //Ikon för nuvarande plats
          icon:
            BitmapDescriptor.defaultMarker,
          position: pos,
        );
      });
  }

  void _testJsonOnMap() async {
    final directions = await HttpRequestHandler()
        .getDirections(routeRequest: 'https://maps.googleapis.com/maps/api/'
        'directions/json?origin=59.4067225,17.9430338'
        '&destination=59.4067225,17.9430338'
        '&waypoints=59.29607465252883,17.9750984081329%7C59.34558289037629,'
        '17.97720364432939%7C59.39911669159036,17.933548971809554'
        '&mode=walking&key=AIzaSyAof5d9wSMDRtbrMAn64WD2swKSJ8JEDNY');
    setState(() => _info = directions);
  }
}