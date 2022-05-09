import 'dart:convert';
import 'package:flutter/material.dart';
import 'googleapikey.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'directions_model.dart';

/*
TODO: En metod för att ta emot routeRequest String som ska komma från backend efter
TODO: vi skickat geoLocation.
 */

class HttpRequestHandler {
  //final Dio _dio;

  //Metoden som ska posta geolocation till backend
  Future<http.Response> postGeoLocation(String latitude, String longitude) {
    return http.post(
      Uri.parse('http://localhost:8080/outr/coordinates?latitude=' + latitude +
          '&longitude=' + longitude),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'latitude': latitude,
        'longitude': longitude,
      }),
    );
  }

  //The method that splits string from Pathfinder and returns either route part or gym part
  //True for route and false for gym

  Future<String?> getStringFromPathfinder(bool onlyRoute) async {
    var _dio = Dio();
    final response = await _dio.get(
        'https://group-4-15.pvt.dsv.su.se/outr/pathfinder/getstring/');
    if (response.statusCode == 200) {
      List<String> routeString = response.data.toString().split('-');
      if (onlyRoute == true) {
        return routeString[0];
      } else {
        return routeString[1];
      }
    }
    return null;
  }

  //Metoden som ska hämta directions från google utifrån String routeRequest som ska skapas i backend
  Future<Directions?> getDirections() async {
    var _dio = Dio();
    String route = getStringFromPathfinder(true) as String;
    final response = await _dio.get(route);

    if(response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}