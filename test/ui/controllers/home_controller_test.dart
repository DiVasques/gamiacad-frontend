import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/models/user.dart';
import 'package:gami_acad/repository/user_repository.dart';
import 'package:gami_acad/ui/controllers/home_controller.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_controller_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('HomeController', () {
    late HomeController homeController;
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      when(userRepository.user).thenReturn(User(
        name: 'name',
        email: 'email',
        registration: 'registration',
        balance: 100,
        totalPoints: 1000,
      ));
    });

    group('getUser', () {
      test('should return user', () async {
        // Arrange
        when(userRepository.getUser(id: 'user-id'))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        homeController = HomeController(
          userId: 'user-id',
          userRepository: userRepository,
        );

        // Act
        await homeController.getUser();

        // Assert
        expect(homeController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed login attempt',
          () async {
        // Arrange
        when(userRepository.getUser(id: 'user-id'))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        homeController = HomeController(
          userId: 'user-id',
          userRepository: userRepository,
        );

        // Act
        await homeController.getUser();

        // Assert
        expect(homeController.errorMessage, 'Error');
        expect(homeController.state, ViewState.error);
      });
    });
  });
}
