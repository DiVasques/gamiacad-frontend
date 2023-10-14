import 'package:gami_acad/repository/reward_repository.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user_rewards.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

class RewardController extends BaseController {
  late String userId;
  late RewardRepository _rewardRepository;

  int _navigationIndex = 0;
  int get navigationIndex => _navigationIndex;
  set navigationIndex(int navigationIndex) {
    _navigationIndex = navigationIndex;
    notifyListeners();
  }

  RewardController({
    required this.userId,
    RewardRepository? rewardRepository,
  }) {
    _rewardRepository = rewardRepository ?? RewardRepository();
    getUserRewards();
  }

  UserRewards get userRewards => _rewardRepository.userRewards;

  Future<void> getUserRewards() async {
    setState(ViewState.busy);
    try {
      Result result = await _rewardRepository.getUserRewards(userId: userId);

      if (result.status) {
        setState(ViewState.idle);
        return;
      }
      setErrorMessage(result.message ?? '');
      setState(ViewState.error);
    } on UnauthorizedException {
      rethrow;
    } on ServiceUnavailableException catch (e) {
      setErrorMessage(e.toString());
      setState(ViewState.error);
    } catch (e) {
      setErrorMessage(ErrorMessages.unknownError);
      setState(ViewState.error);
    }
  }
}
