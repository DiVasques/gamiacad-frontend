class User {
  String name;
  String email;
  String registration;
  int balance;
  int totalPoints;
  User({
    required this.name,
    required this.email,
    required this.registration,
    required this.balance,
    required this.totalPoints,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
        email: json['email'],
        registration: json['registration'],
        balance: json['balance'],
        totalPoints: json['totalPoints'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'registration': registration,
        'balance': balance,
        'totalPoints': totalPoints,
      };
}
