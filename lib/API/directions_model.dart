import 'package:flutter/material.dart';
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

    int count = (data['legs'] as List).length;

    double totalDistance = 0;
    int totalDuration = 0;
    double tempDistance;
    int tempDuration;
    String tempDistanceNoKm;
    String tempDurationNoMin;

    print(count);

    for(int i = 0; i < count; i++){
      var leg = data['legs'][i];

      tempDistanceNoKm = leg['distance']['text'];
      tempDistanceNoKm = tempDistanceNoKm.replaceAll(' km', '');
      tempDistanceNoKm = tempDistanceNoKm.replaceAll(' m', '');
      tempDistanceNoKm = tempDistanceNoKm.replaceAll(',', '.');
      tempDistance = double.parse(tempDistanceNoKm);
      totalDistance += tempDistance;

      tempDurationNoMin = leg['duration']['text'];
      tempDurationNoMin = tempDurationNoMin.replaceAll(' min', '');
      tempDurationNoMin = tempDurationNoMin.replaceAll(' hour', '');
      tempDurationNoMin = tempDurationNoMin.replaceAll(' mins', '');
      tempDurationNoMin = tempDurationNoMin.replaceAll('s', '');
      tempDuration = int.parse(tempDurationNoMin);
      totalDuration += tempDuration;
    }

    String totalDurationString = '';
    if(totalDuration > 179){
      totalDurationString = '3:' + (totalDuration - 180).toString();
    } else if(totalDuration > 119){
      totalDurationString = '2:' + (totalDuration - 120).toString();
    } else if (totalDuration > 59){
      totalDurationString = '1:' + (totalDuration - 60).toString();
    }

    // Distances and duration
    /*String distance = '';
    String duration = '';
    if((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }*/

    return Directions(
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: totalDistance.toString(),
      totalDuration: totalDurationString,
    );
  }
}