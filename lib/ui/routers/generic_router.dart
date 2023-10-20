import 'package:flutter/material.dart';
import 'package:gami_acad/ui/views/mission_details_screen.dart';
import 'package:gami_acad/ui/views/reward_details_screen.dart';
import 'package:gami_acad/ui/views/splash_screen.dart';
import 'package:gami_acad/ui/views/login_screen.dart';
import 'package:gami_acad/ui/views/home_screen.dart';
import 'package:gami_acad/ui/views/mission_screen.dart';
import 'package:gami_acad/ui/views/reward_screen.dart';

class GenericRouter {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String missionRoute = '/mission';
  static const String missionDetailsRoute = '/missionDetails';
  static const String rewardRoute = '/reward';
  static const String rewardDetailsRoute = '/rewardDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case splashRoute:
        builder = (BuildContext _) => const SplashScreen();
        break;
      case loginRoute:
        builder = (BuildContext _) => const LoginScreen();
        break;
      case homeRoute:
        builder = (BuildContext _) =>
            HomeScreen(userId: settings.arguments as String);
        break;
      case missionRoute:
        builder = (BuildContext _) =>
            MissionScreen(userId: settings.arguments as String);
        break;
      case missionDetailsRoute:
        builder = (BuildContext _) => MissionDetailsScreen(
              userId: (settings.arguments as Map<String, dynamic>)['userId'],
              mission: (settings.arguments as Map<String, dynamic>)['mission'],
              canSignOn:
                  (settings.arguments as Map<String, dynamic>)['canSignOn'],
            );
        break;
      case rewardDetailsRoute:
        builder = (BuildContext _) => RewardDetailsScreen(
              userId: (settings.arguments as Map<String, dynamic>)['userId'],
              reward: (settings.arguments as Map<String, dynamic>)['reward'],
              canClaim:
                  (settings.arguments as Map<String, dynamic>)['canClaim'],
              canCancelClaim: (settings.arguments
                  as Map<String, dynamic>)['canCancelClaim'],
            );
        break;
      case rewardRoute:
        builder = (BuildContext _) =>
            RewardScreen(userId: settings.arguments as String);
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
