import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/auth_repository.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/exceptions/user_exists_exception.dart';
import 'package:gami_acad/repository/models/user_access.dart';
import 'package:gami_acad/repository/user_repository.dart';
import 'package:gami_acad/ui/controllers/login_controller.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_controller_test.mocks.dart';

@GenerateMocks([AuthRepository, UserRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('LoginController', () {
    late LoginController loginController;
    late MockAuthRepository authRepository;
    late MockUserRepository userRepository;

    setUp(() {
      authRepository = MockAuthRepository();
      userRepository = MockUserRepository();
      loginController = LoginController(
        authRepository: authRepository,
        userRepository: userRepository,
      );
    });

    group('handleSignInSignUp', () {
      test('should return success login', () async {
        // Arrange
        loginController.loginState = LoginState.login;
        loginController.registration = 'valid_registration';
        loginController.password = 'valid_password';

        when(authRepository.loginUser(
                registration: 'valid_registration', password: 'valid_password'))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));

        // Act
        final result = await loginController.handleSignInSignUp();

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(loginController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed login attempt',
          () async {
        // Arrange
        loginController.loginState = LoginState.login;
        loginController.registration = 'valid_registration';
        loginController.password = 'invalid_password';

        when(authRepository.loginUser(
                registration: 'valid_registration',
                password: 'invalid_password'))
            .thenAnswer((_) async => throw UnauthorizedException());

        // Act
        final result = await loginController.handleSignInSignUp();

        // Assert
        expect(result.status, false);
        expect(result.message, ErrorMessages.failedLoginAttempt);
        expect(loginController.state, ViewState.idle);
      });

      test('should return success signUp', () async {
        // Arrange
        loginController.loginState = LoginState.signUp;
        loginController.registration = 'valid_registration';
        loginController.password = 'valid_password';
        loginController.name = 'valid_name';
        loginController.email = 'valid_email';

        when(authRepository.signUpUser(
                registration: 'valid_registration', password: 'valid_password'))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        when(authRepository.user).thenReturn(UserAccess(
          id: 'valid-id',
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
        ));

        when(userRepository.addUser(
                name: 'valid_name', email: 'valid_email', id: 'valid-id'))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));

        // Act
        final result = await loginController.handleSignInSignUp();

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(loginController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed signUp attempt',
          () async {
        // Arrange
        loginController.loginState = LoginState.signUp;
        loginController.registration = 'valid_registration';
        loginController.password = 'invalid_password';

        when(authRepository.signUpUser(
                registration: 'valid_registration',
                password: 'invalid_password'))
            .thenAnswer((_) async => throw UserExistsException());

        // Act
        final result = await loginController.handleSignInSignUp();

        // Assert
        expect(result.status, false);
        expect(result.message, ErrorMessages.alreadyRegistered);
        expect(loginController.state, ViewState.idle);
      });
    });
  });
}
