import 'dart:convert';
import 'googleapikey.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<http.Response> postGeoLocation(String latitude, String longitude) {
  return http.post(
    Uri.parse('https://yoururlhere'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'latitude': latitude,
      'longitude': longitude,
    }),
  );
}


// Början av http get call till google directions API,
// mapview page måste komplementeras enligt https://medium.com/@shiraz990/flutter-fetching-google-directions-using-changenotifierprovider-f642adbe6cf4
// Detta enbart om det ej går att lösa med en färdig json fil direkt, isåfall måste vi @get koordinater för noder som rutten ska ha och sedan skicka in
// enligt denna get request.
/*
class DirectionsRepo {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepo({required Dio dio}):_dio= dio?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
}) async {
    final response = await _dio.get(_baseUrl,queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
      'destination': '${destination.latitude}, ${destination.longitude}',
      'key': googleAPIKey
    });

    //check if successful
    if(response.statusCode == 200){
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
 */