import 'package:outr/DataClasses/userdata.dart';

class Route{
  final User user;
  final String route;

  const Route({
    required this.user,
    required this.route
  });
  factory Route.fromJson(Map<String, dynamic> json){
    return Route(
        user: json['user'],
        route: json['route']);
  }
}