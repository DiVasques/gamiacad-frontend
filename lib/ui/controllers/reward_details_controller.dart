import 'package:gami_acad/repository/models/base_reward.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/reward_repository.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';

class RewardDetailsController extends BaseController {
  late String userId;
  late BaseReward reward;
  late RewardRepository _rewardRepository;

  RewardDetailsController({
    required this.userId,
    required this.reward,
    RewardRepository? rewardRepository,
  }) {
    _rewardRepository = rewardRepository ?? RewardRepository();
  }

  Future<String?> claimReward() async {
    try {
      Result result = await _rewardRepository.claimReward(
        userId: userId,
        rewardId: reward.id,
      );

      if (result.status) {
        return null;
      }
      return result.message ?? '';
    } on UnauthorizedException {
      rethrow;
    } on ServiceUnavailableException catch (e) {
      return e.toString();
    } catch (e) {
      return ErrorMessages.unknownError;
    }
  }
}
