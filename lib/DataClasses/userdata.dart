
//Klass för Användare-objekt
class User{
  final String name;
  final String email;
  final int noOfCompletedRoutes;
  final int dailyStreak;
  final String createdAt;
  final String lastLogin;
  final int level;
  final int xp;
  final String rank;
  final int xpToNextLevel;
  final int totalXpForNextLevel;

  const User({
    required this.name,
    required this.email,
    required this.noOfCompletedRoutes,
    required this.dailyStreak,
    required this.createdAt,
    required this.lastLogin,
    required this.level,
    required this.xp,
    required this.rank,
    required this.xpToNextLevel,
    required this.totalXpForNextLevel
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        name: json['name'],
        email: json['email'],
        noOfCompletedRoutes: json['noOfCompletedRoutes'],
        dailyStreak: json['dailyStreak'],
        createdAt: json['createdAt'],
        lastLogin: json['lastLogin'],
        level: json['level'],
        xp: json['xp'],
        rank: json['rank'],
        xpToNextLevel: json['xpToNextLevel'],
        totalXpForNextLevel: json['totalXpForNextLevel'],
    );
  }

  String toString(){
    return name + ' ' + email + ' ' + createdAt + ' ' + lastLogin;
  }

}