import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle get overlay => SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          PlatformDispatcher.instance.platformBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
      statusBarBrightness:
          PlatformDispatcher.instance.platformBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
    );
