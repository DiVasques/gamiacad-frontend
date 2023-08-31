import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gami_acad/middlewares/unauthorized_interceptor.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PlatformDispatcher.instance.onError = UnauthorizedInterceptor.onError;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamiAcad',
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: const Color(0xFF1F5F02),
      ),
      onGenerateRoute: GenericRouter.generateRoute,
      initialRoute: GenericRouter.splashRoute,
    );
  }
}
