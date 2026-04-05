import 'package:flutter/material.dart';

class AppSize {
  static late MediaQueryData _mediaQueryData;
  static late double topSafeInset;
  static late double bottomSafeInset;
  static late double leftSafeInset;
  static late double rightSafeInset;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    topSafeInset = _mediaQueryData.viewPadding.top;
    bottomSafeInset = _mediaQueryData.viewPadding.bottom;
    leftSafeInset = _mediaQueryData.viewPadding.left;
    rightSafeInset = _mediaQueryData.viewPadding.right;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  static const double viewMargin = 16;
  static const double viewSpacing = 24;
  static const double inset = 16;
  static const double buttonRadius = 40;
  static const double cornerRadius = 16;
  static const double spacedViewSpacing = 48;
  static const double cornerRadiusSmall = 4;
  static const double cornerRadiusMedium = 8;
  static const double iconHeight = 24;
  static const double largeIconHeight = 50;
  static const double smallIconHeight = 20;
  static const double buttonHeight = 54;
  static const double placeholder = 24;
  static const double profileImageHeight = 80;
  static const double buttonPadding = 12;
  static const double checkBoxHeight = 24;
}
