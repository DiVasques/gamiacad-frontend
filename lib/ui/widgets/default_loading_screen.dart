import 'package:flutter/material.dart';
import 'package:gami_acad/ui/utils/dimensions.dart';

class DefaultLoadingScreen extends StatelessWidget {
  const DefaultLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Dimensions.screenHeight(context) * 0.04,
        width: Dimensions.screenHeight(context) * 0.04,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
