import 'package:flutter/material.dart';
import 'app_size.dart';

extension AppSizeExtension on BuildContext {
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;
  double get hInset => isLandscape ? AppSize.leftSafeInset + AppSize.viewMargin : AppSize.viewMargin;
  double get hInsetR => isLandscape ? AppSize.rightSafeInset + AppSize.viewMargin : AppSize.viewMargin;
  Brightness get brightness => MediaQuery.of(this).platformBrightness;
  bool get isDarkMode => brightness == Brightness.dark;
}
