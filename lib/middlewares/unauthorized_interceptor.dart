import 'package:flutter/material.dart';
import 'package:gami_acad/main.dart';
import 'package:gami_acad/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';

class UnauthorizedInterceptor {
  static bool onError(Object? error, StackTrace stack) {
    if (error.runtimeType != UnauthorizedException) {
      return true;
    }
    _handleNavigation();
    _showDialog(error: error);
    return true;
  }

  static void _handleNavigation() {
    Navigator.of(globalNavigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(GenericRouter.loginRoute, (route) => false);
    return;
  }

  static void _showDialog({Object? error}) {
    showDialog(
      context: globalNavigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            'Login Expirado.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        content: const Text(
          'Entre novamente com suas credenciais para continuar utilizando o aplicativo.',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(globalNavigatorKey.currentContext!).pop();
            },
          ),
        ],
      ),
    );
  }
}
