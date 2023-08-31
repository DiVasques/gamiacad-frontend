import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad/repository/auth_repository.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/ui/controllers/login_controller.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_controller_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('LoginController', () {
    late LoginController loginController;
    late MockAuthRepository authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
      loginController = LoginController(authRepository: authRepository);
    });

    group('handleSignInSignUp', () {
      test('should return success', () async {
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
    });
  });
}
