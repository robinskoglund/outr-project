import 'package:outr/DataClasses/userdata.dart';

class Achievement{
  final User user;
  final String achievementText;
  final String achievementLevel;
  final int id;

  const Achievement({
    required this.user,
    required this.achievementText,
    required this.achievementLevel,
    required this.id
  });
  factory Achievement.fromJson(Map<String, dynamic> json){
    return Achievement(
        user: json['user'],
        achievementText: json['achievementText'],
        achievementLevel: json['achievementLevel'],
        id: json['id']);
  }
}