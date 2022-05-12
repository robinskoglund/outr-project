import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Directions {
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
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


    // Distances and duration
    String distance = '';
    String duration = '';
    if((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return Directions(
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}