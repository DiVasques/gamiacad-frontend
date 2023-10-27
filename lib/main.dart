import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:gami_acad/ui/utils/app_colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gami_acad/middlewares/unauthorized_interceptor.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('pt_BR');
  await dotenv.load();
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
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        dividerTheme: const DividerThemeData(
          space: 2,
          color: Colors.black54,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          elevation: 2,
        ),
        fontFamily: 'Montserrat',
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: GenericRouter.generateRoute,
      initialRoute: GenericRouter.splashRoute,
    );
  }
}
