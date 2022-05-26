import 'package:outr/DataClasses/userdata.dart';

class Route{
  final User user;
  final String route;
  final String typeOfWorkout;
  final double distance;
  final String nameOfRoute;
  final int durationInMinutes;
  final int id;

  const Route({
    required this.user,
    required this.route,
    required this.typeOfWorkout,
    required this.distance,
    required this.nameOfRoute,
    required this.durationInMinutes,
    required this.id
  });
  factory Route.fromJson(Map<String, dynamic> json){
    return Route(
        user: json['user'] as User,
        route: json['route'] as String,
        typeOfWorkout: json['typeOfWorkout'] as String,
        distance: json['distance'] as double,
        nameOfRoute: json['nameOfRoute'] as String,
        durationInMinutes: json['durationInMinutes'] as int,
        id: json['id'] as int);
  }
}