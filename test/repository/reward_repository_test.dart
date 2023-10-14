import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/models/base_reward.dart';
import 'package:gami_acad/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/reward_repository.dart';
import 'package:gami_acad/services/gamiacad_dio_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reward_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('RewardRepository', () {
    late RewardRepository rewardRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

    String userId = 'userId';
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

    setUp(() {
      gamiAcadDioClient = MockGamiAcadDioClient();
      rewardRepository = RewardRepository(
        gamiAcadDioClient: gamiAcadDioClient,
      );
    });

    group('getUserRewards', () {
      test('should return success getUserRewards', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            'available': [baseReward.toJson()],
            'claimed': [],
            'received': [],
          },
        );
        when(gamiAcadDioClient.get(
          path: '/user/$userId/reward',
        )).thenAnswer((_) async => response);

        // Act
        final result = await rewardRepository.getUserRewards(
          userId: userId,
        );

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(rewardRepository.userRewards.available[0].id, baseReward.id);
        expect(rewardRepository.userRewards.available[0].name, baseReward.name);
        expect(
          rewardRepository.userRewards.available[0].description,
          baseReward.description,
        );
        expect(rewardRepository.userRewards.available[0].number,
            baseReward.number);
        expect(
            rewardRepository.userRewards.available[0].price, baseReward.price);
        expect(rewardRepository.userRewards.available[0].availability,
            baseReward.availability);
        expect(
            rewardRepository.userRewards.available[0].count, baseReward.count);
        expect(rewardRepository.userRewards.available[0].createdAt,
            baseReward.createdAt);
        expect(rewardRepository.userRewards.available[0].updatedAt,
            baseReward.updatedAt);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId/reward',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getUserRewards(
            userId: userId,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId/reward',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getUserRewards(
            userId: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId/reward',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getUserRewards(
            userId: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId/reward',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.getUserRewards(
            userId: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
