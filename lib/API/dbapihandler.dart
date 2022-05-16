import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//'https://group-4-15.pvt.dsv.su.se/outr_gyms/all'

class User{
  final String name;
  final String email;
  final int noOfCompletedRoutes;
  final int dailyStreak;
  final String createdAt;
  final String lastLogin;

  const User({
    required this.name,
    required this.email,
    required this.noOfCompletedRoutes,
    required this.dailyStreak,
    required this.createdAt,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      name: json['name'],
      email: json['email'],
      noOfCompletedRoutes: json['noOfCompletedRoutes'],
      dailyStreak: json['dailyStreak'],
      createdAt: json['createdAt'],
      lastLogin: json['lastLogin'],
    );
  }

  String toString(){
    return name + ' ' + email + ' ' + createdAt + ' ' + lastLogin;
  }

}

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

Future<User> getUser(String email) async {
  //För att testa på sin localhost ska använd din ip-adress istället för "localhost" i adressen
  final response = await http.get(Uri.parse('https://group-4-15.pvt.dsv.su.se/outr/data/user/get?email=' + email));

  if(response.statusCode == 200){
    if(response.body.isEmpty){
      return const User(name: "", email: "", noOfCompletedRoutes: 0, dailyStreak: 0, createdAt: "", lastLogin: "");
    }
    return User.fromJson(jsonDecode(response.body));
  } else {
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

  return (response.statusCode == 200);

}