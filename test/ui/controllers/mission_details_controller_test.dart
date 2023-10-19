import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/mission_repository.dart';
import 'package:gami_acad/repository/models/base_mission.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/ui/controllers/mission_details_controller.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mission_details_controller_test.mocks.dart';

@GenerateMocks([MissionRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MissionDetailsController', () {
    late MissionDetailsController missionDetailsController;
    late MockMissionRepository missionRepository;

    String userId = 'userId';
    BaseMission mission = BaseMission(
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

    setUp(() {
      missionRepository = MockMissionRepository();
    });

    group('subscribeOnMission', () {
      test('should subscribe user on mission', () async {
        // Arrange
        when(missionRepository.subscribeOnMission(
          userId: userId,
          missionId: mission.id,
        )).thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionDetailsController = MissionDetailsController(
          userId: userId,
          mission: mission,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionDetailsController.subscribeOnMission();

        // Assert
        expect(result, null);
        expect(missionDetailsController.state, ViewState.idle);
      });

      test(
          'should return error message when failed to subscribe user on mission',
          () async {
        // Arrange
        when(missionRepository.subscribeOnMission(
          userId: userId,
          missionId: mission.id,
        )).thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionDetailsController = MissionDetailsController(
          userId: userId,
          mission: mission,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionDetailsController.subscribeOnMission();

        // Assert
        expect(result, 'Error');
        expect(missionDetailsController.state, ViewState.idle);
      });
    });
  });
}
