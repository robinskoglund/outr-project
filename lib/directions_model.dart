import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  //Check if route is available
  static Directions? fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) return null;

    //Getting information of route
    final data = Map<String, dynamic>.from(map['routes'][0]);

    //Bounds, makes sure the camera fits all the polylinepoints
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      southwest: LatLng(northeast['lat'], northeast['lng']),
      northeast: LatLng(southwest['lat'], southwest['lng']),
    );

    // Distances and duration
    String distance = '';
    String duration = '';
    if((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return Directions(
      bounds: bounds,
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}