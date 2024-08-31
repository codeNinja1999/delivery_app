import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/repository/data/core/core.dart';

import '../../../repository/repository.dart';
import '../../presentation/widgets/widgets.dart';
import '../../route/route.dart';
import '../app_core.dart';

class ErrorResolver {
  static void resolve(BuildContext context, SubmissionFailure status) {
    if (status.error is SessionExpired || status.error is MultipleDeviceDetection) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            title: "Session Expired",
            message: "Oops! It looks like your session expired. Please log back in to continue.",
            primaryButtonTitle: "Okay",
            onPrimaryButtonPressed: () => AppRouter.logoutUser(context),
          );
        },
      );
    } else if (status.error is Failure) {
      SnackbarUtils.showSnackbar(context,
          message: status.error.exceptionMessage, icon: Icons.error, type: SnackBarType.error);
    } else if (status.error is SocketException) {
      SnackbarUtils.showSnackbar(
        context,
        message: "Network error.\nPlease check your network and try again.",
        icon: Icons.error,
        type: SnackBarType.error,
      );
    } else {
      SnackbarUtils.showSnackbar(
        context,
        message: status.error.exceptionMessage,
        icon: Icons.error,
        type: SnackBarType.error,
      );
    }
  }
}
