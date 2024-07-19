import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class LoadingView {
  static show({String? message}) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = AppColors.disabledColorLight
      ..backgroundColor = AppColors.primary
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..userInteractions = false
      ..dismissOnTap = false;
    await EasyLoading.show(status: message);
  }

  static hide() async {
    await EasyLoading.dismiss();
  }
}
