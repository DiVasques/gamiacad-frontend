import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/reward_repository.dart';
import 'package:gami_acad/repository/models/base_reward.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/models/user_rewards.dart';
import 'package:gami_acad/ui/controllers/reward_controller.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reward_controller_test.mocks.dart';

@GenerateMocks([RewardRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('RewardController', () {
    late RewardController rewardController;
    late MockRewardRepository rewardRepository;

    String userId = 'userId';

    setUp(() {
      rewardRepository = MockRewardRepository();
      BaseReward baseReward = BaseReward(
        id: 'id',
        name: 'name',
        description: 'description',
        number: 1,
        price: 100,
        availability: 10,
        count: 5,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      when(rewardRepository.userRewards).thenReturn(
          UserRewards(available: [baseReward], claimed: [], received: []));
    });

    group('getUserRewards', () {
      test('should return user rewards', () async {
        // Arrange
        when(rewardRepository.getUserRewards(userId: userId))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getUserRewards();

        // Assert
        expect(rewardController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed get user rewards',
          () async {
        // Arrange
        when(rewardRepository.getUserRewards(userId: userId))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getUserRewards();

        // Assert
        expect(rewardController.errorMessage, 'Error');
        expect(rewardController.state, ViewState.error);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.getUserRewards(userId: userId))
            .thenThrow((_) async => UnauthorizedException);
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.getUserRewards();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(rewardRepository.getUserRewards(userId: userId))
            .thenThrow((_) async => ServiceUnavailableException);
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getUserRewards();

        // Assert
        expect(rewardController.state, ViewState.error);
      });
    });
  });
}
