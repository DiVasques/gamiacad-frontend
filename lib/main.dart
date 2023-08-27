import 'package:flutter/material.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamiAcad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F5F02))
          // primarySwatch: MaterialColor(
          //   0xFF1F5F02,
          //   {
          //     50: const Color(0xFF1F5F02).withOpacity(.1),
          //     100: const Color(0xFF1F5F02).withOpacity(.2),
          //     200: const Color(0xFF1F5F02).withOpacity(.3),
          //     300: const Color(0xFF1F5F02).withOpacity(.3),
          //     400: const Color(0xFF1F5F02).withOpacity(.4),
          //     500: const Color(0xFF1F5F02).withOpacity(.5),
          //     600: const Color(0xFF1F5F02).withOpacity(.6),
          //     700: const Color(0xFF1F5F02).withOpacity(.7),
          //     800: const Color(0xFF1F5F02).withOpacity(.8),
          //     900: const Color(0xFF1F5F02).withOpacity(.9)
          //   },
          // ),
          ),
      onGenerateRoute: GenericRouter.generateRoute,
      initialRoute: GenericRouter.splashRoute,
    );
  }
}
