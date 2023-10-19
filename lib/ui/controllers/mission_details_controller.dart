import 'package:gami_acad/repository/mission_repository.dart';
import 'package:gami_acad/repository/models/base_mission.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';

class MissionDetailsController extends BaseController {
  late String userId;
  late BaseMission mission;
  late MissionRepository _missionRepository;

  MissionDetailsController({
    required this.userId,
    required this.mission,
    MissionRepository? missionRepository,
  }) {
    _missionRepository = missionRepository ?? MissionRepository();
  }

  Future<String?> subscribeOnMission() async {
    try {
      Result result = await _missionRepository.subscribeOnMission(
        userId: userId,
        missionId: mission.id,
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
