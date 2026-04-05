import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/snack/snackbar.dart';

class AppExitHelper {
  //name of method channel
  static const _platform = MethodChannel('move_to_background');
  static DateTime? _lastPressed;

  static Future<bool> handleBackPress(BuildContext context) async {
    final now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      SnackbarUtils.showToast(context, message: "Press again to exit");
      return false;
    } else {
      return _minimizeApp();
    }
  }

  static Future<bool> _minimizeApp() async {
    if (Platform.isAndroid) {
      //call method channel of method name
      await _platform.invokeMethod<bool>("sendToBackground");
      return true;
    } else if (Platform.isIOS) {
      exit(0);
    }
    return false;
  }
}
