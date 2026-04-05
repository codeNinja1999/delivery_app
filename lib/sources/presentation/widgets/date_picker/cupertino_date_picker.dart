import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

enum PickerType {
  normal, // regular date picker
  issueDate, // cannot select future date
  expiryDate, // cannot select past date
  dob, // cannot select future date, wide range
}

Future<DateTime?> openCupertinoDatePicker({
  required BuildContext context,
  CupertinoDatePickerMode? mode,
  DateTime? selectedDate,
  DateTime? firstDate,
  int? minimumDOB,
  PickerType? type,
}) async {
  // Unfocus input
  if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(const Duration(milliseconds: 300));
  }

  final today = DateTime.now();
  if (!context.mounted) return null;

  // ---- DETERMINE DATE LIMITS ----
  late DateTime initialDate;
  late DateTime? minimumDate;
  late DateTime? maximumDate;

  late int minimumYear;
  late int maximumYear;

  switch (type) {
    case PickerType.issueDate:
      minimumYear = 1900;
      maximumYear = today.year; // cannot pick future
      minimumDate = DateTime(1900);
      maximumDate = today; //this prevent future dates
      initialDate = selectedDate ?? today;
      break;

    case PickerType.expiryDate:
      minimumYear = today.year; // cannot go backwards from today
      maximumYear = 2200;
      minimumDate = DateTime(today.year, today.month, today.day + 1);
      maximumDate = DateTime(2200);
      initialDate = selectedDate ?? today;
      break;

    case PickerType.dob:
      minimumYear = 1900;
      maximumYear = today.year - (minimumDOB ?? 18); // cannot pick future
      minimumDate = DateTime(1900);
      maximumDate = DateTime(today.year - (minimumDOB ?? 18), today.month, today.day);
      initialDate = selectedDate ?? DateTime(today.year - (minimumDOB ?? 18), today.month, today.day);
      break;

    default:
      minimumDate = firstDate ?? DateTime(1900);
      minimumYear = minimumDate.year;
      maximumYear = 2200;
      maximumDate = DateTime(2200);
      initialDate = selectedDate ?? today;
      break;
  }

  // Ensure initialDate is inside limits
  if (mode != CupertinoDatePickerMode.time && initialDate.isBefore(minimumDate)) {
    initialDate = minimumDate;
  }
  // if (initialDate.isAfter(maximumDate)) {
  //   initialDate = maximumDate;
  // }

  // Temporary selected date
  DateTime tempDate = initialDate;

  return showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (popupContext) {
      return Container(
        height: 300,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            // Done Button
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    child: Text(LocaleKeys.doneButtonTitle.value),
                    onPressed: () {
                      Navigator.pop(popupContext, tempDate);
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: CupertinoTheme(
                data: CupertinoTheme.of(context).copyWith(
                  primaryColor: Theme.of(context).colorScheme.primary,
                ),
                child: CupertinoDatePicker(
                  mode: mode ?? CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  minimumYear: mode != CupertinoDatePickerMode.time ? minimumYear : 1,
                  maximumYear: mode != CupertinoDatePickerMode.time ? maximumYear : null,
                  minimumDate: mode != CupertinoDatePickerMode.time ? minimumDate : null,
                  maximumDate: mode != CupertinoDatePickerMode.time ? maximumDate : null,
                  onDateTimeChanged: (newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
