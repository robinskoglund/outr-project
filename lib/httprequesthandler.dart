import 'dart:convert';
import 'googleapikey.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<http.Response> postGeoLocation(String latitude, String longitude) {
  return http.post(
    Uri.parse('http://localhost:8080/outr/coordinates?latitude=' + latitude + '&longitude=' + longitude),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'latitude': latitude,
      'longitude': longitude,
    }),
  );
}