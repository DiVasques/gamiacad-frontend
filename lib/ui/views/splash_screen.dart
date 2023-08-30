import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gami_acad/ui/routers/generic_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      const Duration duration = Duration(seconds: 3);
      Timer(duration, () {
        Navigator.pushNamedAndRemoveUntil(
            context, GenericRouter.loginRoute, (Route<dynamic> route) => false);
      });
    });
    return Scaffold(
      body: Image.asset(
        "assets/images/splash.png",
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
      ),
    );
  }
}
