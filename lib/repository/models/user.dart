class User {
  String id;
  String name;
  String email;
  String registration;
  int balance;
  int totalPoints;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.registration,
    required this.balance,
    required this.totalPoints,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        registration: json['registration'],
        balance: json['balance'],
        totalPoints: json['totalPoints'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'registration': registration,
        'balance': balance,
        'totalPoints': totalPoints,
      };
}
