import 'package:flutter/material.dart';

class Dimensions {
  static const double smallPadding = 5.0;
  static const double inBetweenItensPadding = 15.0;
  static const double mediumPadding = 38.0;
  static const double bigPadding = 60.0;
  static const double sidePadding = 15.0;
  static const double topPadding = 45.0;
  static const double buttonHeight = 52.0;
  static const double spacerWidth = 80.0;

  static const double frontPanelHeight = 65;
  static const double frontPanelOpenPercentage = 0.8;

  static const double profilePictureSize = 50;

  static const double cardElevation = 5.0;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Widget heightSpacer([double height = inBetweenItensPadding]) {
    return SizedBox(
      height: height,
    );
  }

  static Widget widthSpacer([double width = inBetweenItensPadding]) {
    return SizedBox(
      width: width,
    );
  }
}
