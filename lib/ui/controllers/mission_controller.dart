import 'package:gami_acad/repository/mission_repository.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user_missions_.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

class MissionController extends BaseController {
  late String userId;
  late MissionRepository _missionRepository;

  int _navigationIndex = 0;
  int get navigationIndex => _navigationIndex;
  set navigationIndex(int navigationIndex) {
    _navigationIndex = navigationIndex;
    notifyListeners();
  }

  MissionController({
    required this.userId,
    MissionRepository? missionRepository,
  }) {
    _missionRepository = missionRepository ?? MissionRepository();
    getUserMissions();
  }

  UserMissions get userMissions => _missionRepository.userMissions;

  Future<void> getUserMissions() async {
    setState(ViewState.busy);
    try {
      Result result = await _missionRepository.getUserMissions(userId: userId);

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
