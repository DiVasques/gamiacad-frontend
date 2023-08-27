import 'package:flutter/material.dart';
import 'package:gami_acad/ui/views/home_screen.dart';
import 'package:gami_acad/ui/views/splash_screen.dart';

class GenericRouter {
  static const String homeRoute = '/home';
  static const String splashRoute = '/splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case homeRoute:
        builder = (BuildContext _) => const HomeScreen();
        break;
      case splashRoute:
        builder = (BuildContext _) => const SplashScreen();
        break;
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('BUG: Rota não definida para ${settings.name}'),
              ),
            );
          },
        );
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
