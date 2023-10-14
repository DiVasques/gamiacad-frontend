import 'package:gami_acad/repository/models/base_mission.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';

class MissionDetailsController extends BaseController {
  late String userId;
  late BaseMission mission;

  MissionDetailsController({
    required this.userId,
    required this.mission,
  });
}
