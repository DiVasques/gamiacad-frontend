import 'package:gami_acad/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/exceptions/user_exists_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/auth_repository.dart';
import 'package:gami_acad/repository/models/user_access.dart';
import 'package:gami_acad/repository/user_repository.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

enum LoginState { login, signUp }

class LoginController extends BaseController {
  LoginState _loginState = LoginState.login;
  late AuthRepository _authRepository;
  late UserRepository _userRepository;

  LoginController(
      {AuthRepository? authRepository, UserRepository? userRepository}) {
    _authRepository = authRepository ?? AuthRepository();
    _userRepository = userRepository ?? UserRepository();
  }

  UserAccess get userAccess => _authRepository.user;

  LoginState get loginState => _loginState;
  set loginState(LoginState loginState) {
    _loginState = loginState;
    notifyListeners();
  }

  String? _uid;
  String? _name;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _registration;

  String? get uid => _uid;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  String? get confirmPassword => _confirmPassword;
  String? get registration => _registration;

  set uid(value) {
    _uid = value;
    notifyListeners();
  }

  set name(value) {
    _name = value;
    notifyListeners();
  }

  set email(value) {
    _email = value;
    notifyListeners();
  }

  set password(value) {
    _password = value;
    notifyListeners();
  }

  set confirmPassword(value) {
    _confirmPassword = value;
    notifyListeners();
  }

  set registration(value) {
    _registration = value;
    notifyListeners();
  }

  void clearInputs() {
    _uid = null;
    _name = null;
    _email = null;
    _password = null;
    _confirmPassword = null;
    _registration = null;
    notifyListeners();
  }

  Future<Result> handleSignInSignUp() async {
    setState(ViewState.busy);
    try {
      if (_loginState == LoginState.login) {
        return await _handleSignIn();
      }
      return await _handleSignUp();
    } on UnauthorizedException {
      return Result(status: false, message: ErrorMessages.failedLoginAttempt);
    } on UserExistsException catch (e) {
      return Result(status: false, message: e.toString());
    } on ServiceUnavailableException catch (e) {
      return Result(status: false, message: e.toString());
    } catch (error) {
      return Result(status: false, message: ErrorMessages.unknownError);
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<Result> _handleSignIn() async {
    return await _authRepository.loginUser(
      registration: registration!,
      password: password!,
    );
  }

  Future<Result> _handleSignUp() async {
    Result authResult = await _authRepository.signUpUser(
      registration: registration!,
      password: password!,
    );
    if (!authResult.status) {
      throw ServiceUnavailableException();
    }
    authResult = await _userRepository.addUser(
      id: _authRepository.user.id,
      name: name!,
      email: email!,
      registration: registration!,
    );
    return authResult;
  }
}
