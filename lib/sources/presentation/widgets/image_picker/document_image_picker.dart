import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

Future<void> showOptionsDialog(BuildContext context, {required Function(ScanBy) onCompletion}) {
  final theme = Theme.of(context);
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        titlePadding: const EdgeInsets.only(
          top: AppSize.inset,
          left: AppSize.viewMargin,
          right: AppSize.inset,
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Options", style: theme.textTheme.bodyLarge),
          IconButton(
            onPressed: () => Navigator.pop(context, true),
            splashRadius: 24,
            icon: Icon(
              Icons.close,
              color: theme.colorScheme.primary,
              size: AppSize.viewMargin,
            ),
          ),
        ]),
        contentPadding: const EdgeInsets.only(left: AppSize.viewMargin),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 0,
                leading: Icon(Icons.camera, color: theme.colorScheme.primary),
                title: Text("Image From Camera", style: theme.textTheme.bodyMedium),
              ),
              onTap: () {
                onCompletion(ScanBy.camera);
                Navigator.pop(context, true);
              },
            ),
            GestureDetector(
              child: ListTile(
                minLeadingWidth: 0,
                contentPadding: const EdgeInsets.only(bottom: AppSize.inset),
                leading: Icon(Icons.image, color: theme.colorScheme.primary),
                title: Text("Image From Gallery", style: theme.textTheme.bodyMedium),
              ),
              onTap: () {
                onCompletion(ScanBy.library);
                Navigator.pop(context, true);
              },
            )
          ],
        ),
      );
    },
  );
}
