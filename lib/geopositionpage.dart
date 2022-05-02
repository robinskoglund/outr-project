import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'httprequesthandler.dart';

class GeoLocationScreen extends StatefulWidget {
  @override
  _GeoLocationScreenState createState() => _GeoLocationScreenState();
}

//This is the class where we can change the state of our stateful widget/class.
class _GeoLocationScreenState extends State<GeoLocationScreen> {
  String latitude = "";
  String longitude = "";

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  //function within the class that uses the Geolocator library in order to
  //get the current coordinates/location of the device. We change the state
  //too these coordinates
  getCurrentLocation() async {
    var geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = '${geoposition.latitude}';
      longitude = '${geoposition.longitude}';
    });
  }

  //Here we build the context, what you see on the screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Text(latitude),
          Text(longitude),
        ],
      )
    );
  }
}


