import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/models/base_mission.dart';
import 'package:gami_acad/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/mission_repository.dart';
import 'package:gami_acad/services/gamiacad_dio_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mission_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MissionRepository', () {
    late MissionRepository missionRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

    String userId = 'userId';
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

    setUp(() {
      gamiAcadDioClient = MockGamiAcadDioClient();
      missionRepository = MissionRepository(
        gamiAcadDioClient: gamiAcadDioClient,
      );
    });

    group('getUserMissions', () {
      test('should return success getUserMissions', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            'active': [baseMission.toJson()],
            'participating': [],
            'completed': [],
          },
        );
        when(gamiAcadDioClient.get(
          path: '/user/$userId/mission',
        )).thenAnswer((_) async => response);

        // Act
        final result = await missionRepository.getUserMissions(
          userId: userId,
        );

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(missionRepository.userMissions.active[0].id, baseMission.id);
        expect(missionRepository.userMissions.active[0].name, baseMission.name);
        expect(
          missionRepository.userMissions.active[0].description,
          baseMission.description,
        );
        expect(missionRepository.userMissions.active[0].number,
            baseMission.number);
        expect(missionRepository.userMissions.active[0].points,
            baseMission.points);
        expect(missionRepository.userMissions.active[0].expirationDate,
            baseMission.expirationDate);
        expect(missionRepository.userMissions.active[0].createdAt,
            baseMission.createdAt);
        expect(missionRepository.userMissions.active[0].updatedAt,
            baseMission.updatedAt);
        expect(missionRepository.userMissions.active[0].createdBy,
            baseMission.createdBy);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId/mission',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.getUserMissions(
            userId: userId,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId/mission',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.getUserMissions(
            userId: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId/mission',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.getUserMissions(
            userId: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId/mission',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.getUserMissions(
            userId: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
