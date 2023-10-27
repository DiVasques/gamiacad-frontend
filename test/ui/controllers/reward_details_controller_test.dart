import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/reward_repository.dart';
import 'package:gami_acad/repository/models/base_reward.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/ui/controllers/reward_details_controller.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reward_details_controller_test.mocks.dart';

@GenerateMocks([RewardRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('RewardDetailsController', () {
    late RewardDetailsController rewardDetailsController;
    late MockRewardRepository rewardRepository;

    String userId = 'userId';
    BaseReward reward = BaseReward(
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

    setUp(() {
      rewardRepository = MockRewardRepository();
    });

    group('claimReward', () {
      test('should claim user reward', () async {
        // Arrange
        when(rewardRepository.claimReward(
          userId: userId,
          rewardId: reward.id,
        )).thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardDetailsController = RewardDetailsController(
          userId: userId,
          reward: reward,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardDetailsController.claimReward();

        // Assert
        expect(result, null);
        expect(rewardDetailsController.state, ViewState.idle);
      });

      test('should return error message when failed to claim user reward',
          () async {
        // Arrange
        when(rewardRepository.claimReward(
          userId: userId,
          rewardId: reward.id,
        )).thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardDetailsController = RewardDetailsController(
          userId: userId,
          reward: reward,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardDetailsController.claimReward();

        // Assert
        expect(result, 'Error');
        expect(rewardDetailsController.state, ViewState.idle);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.claimReward(
          userId: userId,
          rewardId: reward.id,
        )).thenThrow((_) async => UnauthorizedException);
        rewardDetailsController = RewardDetailsController(
          userId: userId,
          reward: reward,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardDetailsController.claimReward();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error message when another exception', () async {
        // Arrange
        when(rewardRepository.claimReward(
          userId: userId,
          rewardId: reward.id,
        )).thenThrow((_) async => ServiceUnavailableException);
        rewardDetailsController = RewardDetailsController(
          userId: userId,
          reward: reward,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardDetailsController.claimReward();

        // Assert
        expect(result?.isNotEmpty, true);
        expect(rewardDetailsController.state, ViewState.idle);
      });
    });

    group('cancelClaim', () {
      test('should cancel reward claim', () async {
        // Arrange
        when(rewardRepository.cancelClaim(
          userId: userId,
          rewardId: reward.id,
        )).thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardDetailsController = RewardDetailsController(
          userId: userId,
          reward: reward,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardDetailsController.cancelClaim();

        // Assert
        expect(result, null);
        expect(rewardDetailsController.state, ViewState.idle);
      });

      test('should return error message when failed to cancel reward claim',
          () async {
        // Arrange
        when(rewardRepository.cancelClaim(
          userId: userId,
          rewardId: reward.id,
        )).thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardDetailsController = RewardDetailsController(
          userId: userId,
          reward: reward,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardDetailsController.cancelClaim();

        // Assert
        expect(result, 'Error');
        expect(rewardDetailsController.state, ViewState.idle);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.cancelClaim(
          userId: userId,
          rewardId: reward.id,
        )).thenThrow((_) async => UnauthorizedException);
        rewardDetailsController = RewardDetailsController(
          userId: userId,
          reward: reward,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardDetailsController.cancelClaim();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error message when another exception', () async {
        // Arrange
        when(rewardRepository.cancelClaim(
          userId: userId,
          rewardId: reward.id,
        )).thenThrow((_) async => ServiceUnavailableException);
        rewardDetailsController = RewardDetailsController(
          userId: userId,
          reward: reward,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardDetailsController.cancelClaim();

        // Assert
        expect(result?.isNotEmpty, true);
        expect(rewardDetailsController.state, ViewState.idle);
      });
    });
  });
}
