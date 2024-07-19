import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fresh_fold_delivery/sources/resources/resources.dart';

enum SnackBarType { error, success, message }

class SnackbarUtils {
  static showToast(BuildContext context, {String? message, Color? color}) {
    Fluttertoast.showToast(
        msg: message ?? "", // message
        backgroundColor: color,
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM);
  }

  static showSnackbar(BuildContext context, {String? message, IconData? icon, SnackBarType type = SnackBarType.message}) {
    var color = Colors.white;
    switch (type) {
      case SnackBarType.message:
        color = Colors.blue;
        break;
      case SnackBarType.error:
        color = Colors.red.shade400;
        break;
      case SnackBarType.success:
        color = Colors.green;
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: AppColors.backgroundLight),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message ?? "", maxLines: 2),
          )
        ],
      ),
    ));
  }
}
