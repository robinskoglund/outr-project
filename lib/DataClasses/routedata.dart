import 'package:outr/DataClasses/userdata.dart';

class RouteObject{
  final String route;
  final String typeOfWorkout;
  final String distance;
  final String nameOfRoute;
  final String durationInMinutes;
  final int id;

  const RouteObject({
    required this.route,
    required this.typeOfWorkout,
    required this.distance,
    required this.nameOfRoute,
    required this.durationInMinutes,
    required this.id
  });
  factory RouteObject.fromJson(Map<String, dynamic> json){
    return RouteObject(
        route: json['route'] as String,
        typeOfWorkout: json['typeOfWorkout'] as String,
        distance: json['distance'] as String,
        nameOfRoute: json['nameOfRoute'] as String,
        durationInMinutes: json['durationInMinutes'] as String,
        id: json['id'] as int);
  }
}