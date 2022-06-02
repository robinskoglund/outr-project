import 'package:outr/DataClasses/userdata.dart';

//Klass för Achievement-objekt
class Achievement{
  final String achievementText;
  final String typeOfWorkout;
  final int id;

  const Achievement({
    required this.achievementText,
    required this.typeOfWorkout,
    required this.id
  });
  factory Achievement.fromJson(Map<String, dynamic> json){
    return Achievement(
        achievementText: json['achievementText'],
        typeOfWorkout: json['typeOfWorkout'],
        id: json['id']);
  }
}