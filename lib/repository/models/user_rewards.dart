import 'package:gami_acad/repository/models/base_reward.dart';

class UserRewards {
  List<BaseReward> available;
  List<BaseReward> claimed;
  List<BaseReward> received;
  UserRewards({
    required this.available,
    required this.claimed,
    required this.received,
  });

  factory UserRewards.fromJson(Map<String, dynamic> json) => UserRewards(
        available: (json['available'] as List<dynamic>)
            .map((e) => BaseReward.fromJson(e))
            .toList(),
        claimed: (json['claimed'] as List<dynamic>)
            .map((e) => BaseReward.fromJson(e))
            .toList(),
        received: (json['received'] as List<dynamic>)
            .map((e) => BaseReward.fromJson(e))
            .toList(),
      );
}
