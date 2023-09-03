import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/user_repository.dart';
import 'package:gami_acad/services/gamiacad_dio_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('UserRepository', () {
    late UserRepository userRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

    String userId = 'userId';
    String name = 'valid_name';
    String email = 'valid_email';
    String registration = 'valid_registration';
    int balance = 1500;
    int totalPoints = 3000;

    setUp(() {
      gamiAcadDioClient = MockGamiAcadDioClient();
      userRepository = UserRepository(
        gamiAcadDioClient: gamiAcadDioClient,
      );
    });

    group('addUser', () {
      test('should return success addUser', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 201,
          statusMessage: 'Success',
        );
        when(gamiAcadDioClient.post(
          path: '/user/$userId',
          body: {
            'name': name,
            'email': email,
            'registration': registration,
          },
        )).thenAnswer((_) async => response);

        // Act
        final result = await userRepository.addUser(
          id: userId,
          name: name,
          email: email,
          registration: registration,
        );

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/user/$userId',
          body: {
            'name': name,
            'email': email,
            'registration': registration,
          },
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await userRepository.addUser(
            id: userId,
            name: name,
            email: email,
            registration: registration,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/user/$userId',
          body: {
            'name': name,
            'email': email,
            'registration': registration,
          },
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 500),
          ),
        );

        // Act and Assert
        try {
          await userRepository.addUser(
            id: userId,
            name: name,
            email: email,
            registration: registration,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/user/$userId',
          body: {
            'name': name,
            'email': email,
            'registration': registration,
          },
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await userRepository.addUser(
            id: userId,
            name: name,
            email: email,
            registration: registration,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('getUser', () {
      test('should return success getUser', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            '_id': userId,
            'name': name,
            'email': email,
            'registration': registration,
            'balance': balance,
            'totalPoints': totalPoints,
          },
        );
        when(gamiAcadDioClient.get(
          path: '/user/$userId',
        )).thenAnswer((_) async => response);

        // Act
        final result = await userRepository.getUser(
          id: userId,
        );

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(userRepository.user.id, userId);
        expect(userRepository.user.name, name);
        expect(userRepository.user.email, email);
        expect(userRepository.user.registration, registration);
        expect(userRepository.user.balance, balance);
        expect(userRepository.user.totalPoints, totalPoints);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await userRepository.getUser(
            id: userId,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await userRepository.getUser(
            id: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await userRepository.getUser(
            id: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user/$userId',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await userRepository.getUser(
            id: userId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
