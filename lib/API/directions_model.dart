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

    double totalDistancee = 0;
    int totalDurationn = 0;
    double tempDistance;
    int tempDuration;
    String tempDistanceNoKm;
    String tempDurationNoMin;

    for(int i = 0; i < count; i++){
      var leg = data['legs'][i];

      //Temporär fullösning för att kunna hantera distance och duration strängarna från en rutt/direction
      tempDistanceNoKm = leg['distance']['text'];
      tempDistanceNoKm = tempDistanceNoKm.replaceAll(' km', '');
      tempDistanceNoKm = tempDistanceNoKm.replaceAll(' m', '');
      tempDistanceNoKm = tempDistanceNoKm.replaceAll(',', '.');
      tempDistance = double.parse(tempDistanceNoKm);
      totalDistancee += tempDistance;

      tempDurationNoMin = leg['duration']['text'];
      tempDurationNoMin = tempDurationNoMin.replaceAll(' mins', '');
      tempDurationNoMin = tempDurationNoMin.replaceAll(' min', '');
      tempDurationNoMin = tempDurationNoMin.replaceAll(' hour', '');
      tempDurationNoMin = tempDurationNoMin.replaceAll('s', '');
      List splitString;
      if(tempDurationNoMin.contains(' ')){
        splitString = tempDurationNoMin.split(' ');
        int splitString1 = int.parse(splitString[0]);
        splitString1 = splitString1 * 60;
        int splitString2 = int.parse(splitString[1]);
        tempDuration = splitString1 + splitString2;
      } else{
        tempDuration = int.parse(tempDurationNoMin);
      }
      totalDurationn += tempDuration;
    }

    String totalDurationString = '';
    if(totalDurationn > 179){
      totalDurationString = '3:' + (totalDurationn - 180).toString();
    } else if(totalDurationn > 119){
      totalDurationString = '2:' + (totalDurationn - 120).toString();
    } else if (totalDurationn > 59){
      totalDurationString = '1:' + (totalDurationn - 60).toString();
    } else{
      totalDurationString = totalDurationn.toString() + ' min';
    }

    totalDistancee = double.parse(totalDistancee.toStringAsFixed(2));

    // Distances and duration
    /*String distance = '';
    String duration = '';
    if((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }*/

    //Returnera en "Directions" som innehåller polylines(rutt linjerna på kartan) samt distance/duration
    return Directions(
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: totalDistancee.toString(),
      totalDuration: totalDurationString,
    );
  }

  void clear(){

  }
}