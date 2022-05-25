import 'dart:convert';
import 'dart:ffi';
import 'googleapikey.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'directions_model.dart';
import '../ScreenPages/mapview_page.dart';

class HttpRequestHandler{
  String route = '';
  String userLevel = '';
  String userStreak = '';
  String userRank = '';
  String userExperience = '';

  //Metoden som ska posta geolocation till backend
  Future<String> getMixRoute(double lat, double long, int duration, int speed) async {
    final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/pathfinder/getmixedroute?originLatitude=' +
        lat.toString() + '&originLongitude=' +
        long.toString() + '&distanceOrDuration=' +
        duration.toString() + '&speed' +
        speed.toString()));
    if(response.statusCode == 200){
      route = response.body;
    } else {
      throw Exception('Failed to get route');
    }
    return route;
  }

  Future<String> getStrengthRoute(double lat, double long) async {
    final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/pathfinder/getpathtoclosestgym?originLatitude=' +
        lat.toString() + '&originLongitude=' +
        long.toString()));

    if(response.statusCode == 200){
      route = response.body;
    } else {
      throw Exception('Failed to get route');
    }
    return route;
  }

  Future<String> getCardioRoute(double lat, double long, int duration, int speed) async {
    final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/pathfinder/getrandomroute?originLatitude=' +
        lat.toString() + '&originLongitude=' +
        long.toString() + '&distanceOrDuration=' +
        duration.toString() + '&speed' +
        speed.toString()));
    if(response.statusCode == 200){
      route = response.body;
    } else {
      throw Exception('Failed to get route');
    }
    return route;
  }

  Future<String> getUserLevel(String email) async {
    final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/get/level?email=' + email.toLowerCase()));
    if(response.statusCode == 200){
      userLevel = response.body;
    } else {
      throw Exception('Failed to get user level');
    }
    return userLevel;
  }

  Future<String> getUserStreak(String email) async {
    final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/get/dailyStreak?email=' + email.toLowerCase()));
    if(response.statusCode == 200){
      userStreak = response.body;
    } else {
      throw Exception('Failed to get user level');
    }
    return userStreak;
  }

  Future<String> getUserRank(String email) async {
    final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/get?email=' + email.toLowerCase()));
    if(response.statusCode == 200){
      userRank = response.body;
    } else {
      throw Exception('Failed to get user rank');
    }
    return userRank;
  }

  Future<String> getUserExp(String email) async {
    final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/get/xp?email=' + email.toLowerCase()));
    if(response.statusCode == 200){
      userExperience = response.body;
    } else {
      throw Exception('Failed to get user rank');
    }
    return userExperience;
  }

  //Metoden som ska hämta directions från google utifrån String routeRequest som ska skapas i backend
  Future<Directions?> getDirections(String route) async {
    var _dio = Dio();

    final response = await _dio.get(route + googleAPIKey);
    if(response.statusCode == 200) {
      print(response);
      return Directions.fromMap(response.data);
    }
    return null;
  }

  String getRoute() {
    return route;
  }
}