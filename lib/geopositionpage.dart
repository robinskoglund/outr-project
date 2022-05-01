import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationScreen extends StatefulWidget {
  @override
  _GeoLocationScreenState createState() => _GeoLocationScreenState();
}

class _GeoLocationScreenState extends State<GeoLocationScreen> {
  String latitudeData = "";
  String longitudeData = "";

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    var geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitudeData = '${geoposition.latitude}';
      longitudeData = '${geoposition.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Text(latitudeData),
          Text(longitudeData),
        ],
      )
    );
  }
}


