import 'package:gami_acad/repository/models/base_mission.dart';

class UserMissions {
  List<BaseMission> active;
  List<BaseMission> participating;
  List<BaseMission> completed;
  UserMissions({
    required this.active,
    required this.participating,
    required this.completed,
  });

  factory UserMissions.fromJson(Map<String, dynamic> json) => UserMissions(
        active: (json['active'] as List<dynamic>)
            .map((e) => BaseMission.fromJson(e))
            .toList(),
        participating: (json['participating'] as List<dynamic>)
            .map((e) => BaseMission.fromJson(e))
            .toList(),
        completed: (json['completed'] as List<dynamic>)
            .map((e) => BaseMission.fromJson(e))
            .toList(),
      );
}
