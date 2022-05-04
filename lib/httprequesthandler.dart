import 'dart:convert';
import 'dart:js';
import 'package:flutter/material.dart';
import 'googleapikey.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'directions_model.dart';

class HttpRequestHandler {
  final Dio _dio;
  HttpRequestHandler({required Dio dio}) : _dio = dio;

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

  //Metoden som ska hämta directions från google utifrån String routeRequest som ska skapas i backend
  Future<Directions?> getDirections({required String routeRequest}) async {
    final response = await _dio.get(routeRequest);

    if(response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}