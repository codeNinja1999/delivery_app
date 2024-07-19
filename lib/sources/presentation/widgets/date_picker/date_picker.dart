import 'dart:core';

import 'package:flutter/material.dart';

Future<DateTime?> openDatePicker({required BuildContext context, int? minimumYear, DateTime? date}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (date != null)
          ? date
          : minimumYear != null
              ? DateTime.now().subtract(Duration(days: minimumYear * 365))
              : DateTime.now().add(const Duration(days: 1)),
      firstDate: minimumYear != null ? DateTime(1940) : DateTime.now(),
      lastDate: minimumYear != null ? DateTime.now().subtract(Duration(days: minimumYear * 365)) : DateTime(2200),
      cancelText: "CANCEL",
      confirmText: "OK",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
            ),
          ),
          child: child!,
        );
      });

  return picked;
}
