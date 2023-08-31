import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/repository/models/result.dart';
import 'package:gami_acad/repository/auth_repository.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

enum LoginState { login, signUp }

class LoginController extends BaseController {
  LoginState _loginState = LoginState.login;
  late AuthRepository _authRepository;

  LoginController({AuthRepository? authRepository}) {
    _authRepository = authRepository ?? AuthRepository();
  }

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
    } on Exception catch (error) {
      return Result(
          status: false, message: ErrorMessages.getExceptionMessage(error));
    } catch (error) {
      return Result(status: false, message: ErrorMessages.unknownError);
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<Result> _handleSignIn() async {
    Result authResult = await _authRepository.loginUser(
      registration: registration!,
      password: password!,
    );
    return authResult;
  }

  Future<Result> _handleSignUp() async {
    throw Exception('not implemented');
  }
}
