import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/mission_repository.dart';
import 'package:gami_acad/repository/models/base_mission.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user_missions.dart';
import 'package:gami_acad/ui/controllers/mission_controller.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mission_controller_test.mocks.dart';

@GenerateMocks([MissionRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MissionController', () {
    late MissionController missionController;
    late MockMissionRepository missionRepository;

    String userId = 'userId';

    setUp(() {
      missionRepository = MockMissionRepository();
      BaseMission baseMission = BaseMission(
        id: 'id',
        name: 'name',
        description: 'description',
        number: 1,
        points: 100,
        expirationDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: 'createdBy',
      );
      when(missionRepository.userMissions).thenReturn(UserMissions(
          active: [baseMission], participating: [], completed: []));
    });

    group('getUserMissions', () {
      test('should return user missions', () async {
        // Arrange
        when(missionRepository.getUserMissions(userId: userId))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        await missionController.getUserMissions();

        // Assert
        expect(missionController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed get user missions',
          () async {
        // Arrange
        when(missionRepository.getUserMissions(userId: userId))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        await missionController.getUserMissions();

        // Assert
        expect(missionController.errorMessage, 'Error');
        expect(missionController.state, ViewState.error);
      });
    });
  });
}
