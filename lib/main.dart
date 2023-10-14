import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gami_acad/middlewares/unauthorized_interceptor.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('pt_BR');
  PlatformDispatcher.instance.onError = UnauthorizedInterceptor.onError;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  final Color primaryColor = const Color(0xFF1F5F02);
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamiAcad',
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: primaryColor),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        dividerTheme: const DividerThemeData(
          space: 2,
          color: Colors.black54,
        ),
        fontFamily: 'Montserrat',
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      onGenerateRoute: GenericRouter.generateRoute,
      initialRoute: GenericRouter.splashRoute,
    );
  }
}
