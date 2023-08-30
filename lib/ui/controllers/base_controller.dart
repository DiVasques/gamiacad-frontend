import 'package:flutter/material.dart';
import 'package:gami_acad/ui/utils/view_state.dart';

class BaseController extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  String _errorMessage = '';

  ViewState get state => _state;
  String get errorMessage => _errorMessage;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
