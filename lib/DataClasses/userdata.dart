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

  const User({
    required this.name,
    required this.email,
    required this.noOfCompletedRoutes,
    required this.dailyStreak,
    required this.createdAt,
    required this.lastLogin,
    required this.level,
    required this.xp,
    required this.rank
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
        rank: json['rank']
    );
  }

  String toString(){
    return name + ' ' + email + ' ' + createdAt + ' ' + lastLogin;
  }

}