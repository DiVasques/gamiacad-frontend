import 'package:gami_acad/repository/models/base_reward.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';

class RewardDetailsController extends BaseController {
  late String userId;
  late BaseReward reward;

  RewardDetailsController({
    required this.userId,
    required this.reward,
  });
}
