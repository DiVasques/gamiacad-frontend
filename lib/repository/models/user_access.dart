class UserAccess {
  String id;
  String accessToken;
  String refreshToken;
  UserAccess({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserAccess.fromJson(Map<String, dynamic> json) => UserAccess(
        id: json['userId'],
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );

  Map<String, dynamic> toJson() => {
        'userId': id,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
