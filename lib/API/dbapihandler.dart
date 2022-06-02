import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:outr/DataClasses/achievementdata.dart';
import 'package:outr/DataClasses/routedata.dart' as r;
import 'dart:convert';

import '../DataClasses/userdata.dart';

//'https://group-4-15.pvt.dsv.su.se/outr_gyms/all'

Future<User> getUser(String email) async {
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/get?email=' + email));

  if(response.statusCode == 200){
    if(response.body.isEmpty){
      return const User(name: "", email: "", noOfCompletedRoutes: 0, dailyStreak: 0, createdAt: "", lastLogin: "", level: 1, xp: 0, rank: "", xpToNextLevel: 5000, totalXpForNextLevel: 5000);
    }
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get user');
  }
}

//Kontroll ifall användare finns i databas
Future<bool> userExists(String email) async {
  final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/get?email=' + email));
  if(response.statusCode == 200){
    if(response.body.isEmpty){
      return false;
    }
    return true;
  }else{
    throw Exception('Failed to get user');
  }
}

Future<http.Response> addUser(String name, String email){
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  return http.post(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/add?name=' + name + '&email=' + email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
    }),
  );
}

Future<http.Response> updateLogin(String email){
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  return http.put(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/update/lastLogin?email=' + email),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body :jsonEncode(<String, String>{
      'email': email,
    }),
  );
}

Future<http.Response> addLogin(String email, String password){
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  return http.post(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/login/add?email=' + email + '&password=' + password),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
}

Future<bool> checkPassword(String email, String password) async {
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/login/checkLogin?email=' + email + '&password=' + password));

  if(response.statusCode == 200){
    if(response.body == 'true')
      return true;
  }
  return false;

}

//Get request för att hämta ut specifik användares sparade rutter
Future<List<r.Route>> getAllUserRoutes(String email) async {
  final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/route/getAllUserRoutes?email=' + email));

  if(response.statusCode == 200){
    return parseRoutes(response.body);
  }
  throw 'Something went wrong';
}

//För att parsa rutter och returnera som en lista
List<r.Route> parseRoutes(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<r.Route>((json) => r.Route.fromJson(json)).toList();
}

//Get request för att hämta ut alla achievements från databas och returnera som en lista
Future<List<Achievement>> getAllUserAchievements(String email) async{
  final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/achievement/getAllForUser?email=' + email));

  if(response.statusCode == 200){
    return parseAchievements(response.body);
  }
  throw 'Something went wrong';
}

//För att parsa achievements och returnera som en lista
List<Achievement> parseAchievements(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Achievement>((json) => Achievement.fromJson(json)).toList();
}

Future<http.Response> saveRoute(String email, String route, String typeOfWorkout, String distance,
    String nameOfRoute, String duration){
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  return http.post(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/route/add?email=' + email + '&route=' + route +
      '&typeOfWorkout=' + typeOfWorkout + '&distance=' + distance+ "&nameOfRoute=" + nameOfRoute + '&duration=' + duration),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body :jsonEncode(<String, String>{
      'email': email,
      'route': route,
      'typeOfWorkout': typeOfWorkout,
      'distance': distance,
      'nameOfRoute': nameOfRoute,
      'duration': duration
    }),
  );
}

Future<http.Response> saveAchievement(String email, String achievementText, String typeOfWorkout){
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  return http.post(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/achievement/add?email=' + email +
      '&achievementText=' + achievementText + '&typeOfWorkout=' + typeOfWorkout),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body :jsonEncode(<String, String>{
      'email': email,
      'achievementText': achievementText,
      'typeOfWorkout': typeOfWorkout
    }),
  );
}

Future<http.Response> updateXp(String email, int xp){
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  print('https://group-4-15.pvt.dsv.su.se/outr/data/user/increaseXP?email=' + email +
      '&xp=' + xp.toString());
  return http.put(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/increaseXp?email=' + email +
    '&xp=' + xp.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body :jsonEncode(<String, String>{
      'email': email,
      'xp': xp.toString()
    }),
  );
}

