import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'directions_model.dart';
import 'geopositionpage.dart';

/*
TODO: Fixa så _addGeoLocMarker och _addGymMarker används och skapar markers.
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
  late Directions _info;

  late Marker _origin;
  late Marker _destination;

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
        markers: {
          //Lägga till markers här sen, de vi kan skapa med _addGeoLocMarker() och _addGymMarker()
        },

        //Lägga till polylines på kartan
        polylines: {
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.red,
            width: 5,
            points: _info.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
          )
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

  //Metod för att skapa gym marker
  void _addGymMarker(LatLng pos) {
    setState(() {
      _destination = Marker(
        markerId: const MarkerId('Destination'),

        //Vad som visas när man klickar på marker
        infoWindow: const InfoWindow(title: 'Destination'),

        //Ikon för gym
        icon:
        BitmapDescriptor.defaultMarker,
        position: pos,
      );
    });
  }
}