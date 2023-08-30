import 'package:flutter/material.dart';
import 'package:gami_acad/services/models/result.dart';
import 'package:gami_acad/ui/controllers/base_controller.dart';
import 'package:gami_acad/ui/utils/error_messages.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

enum LoginState { login, signUp }

class LoginController extends BaseController {
  LoginState _loginState = LoginState.login;

  LoginState get loginState => _loginState;
  set loginState(LoginState loginState) {
    _loginState = loginState;
    notifyListeners();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

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

  bool _validateAndSaveFields() {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      return true;
    } else {
      return false;
    }
  }

  Future<Result> handleSignInSignUp() async {
    if (_validateAndSaveFields()) {
      setState(ViewState.busy);
      if (_loginState == LoginState.login) {
        await Future.delayed(const Duration(seconds: 2));
        Result authResult = Result(status: true);

        setState(ViewState.idle);
        return authResult;
      }
      await Future.delayed(const Duration(seconds: 2));
      Result authResult = Result(status: true);

      setState(ViewState.idle);
      return authResult;
    }
    return Result(status: false, errorCode: ErrorMessages.invalidInputs);
  }
}
