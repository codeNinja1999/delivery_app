import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

Future<dynamic> memberBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(AppSize.inset),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            LocaleKeys.createAccount.value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
          ),
          const SizedBox(height: AppSize.inset),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.account_box),
            title: Text(LocaleKeys.newMemberTitle.value),
            onTap: () => Navigator.of(context).popAndPushNamed(AppRoute.newMemberPage),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.account_box),
            title: Text(LocaleKeys.existingMemberTitle.value),
            onTap: () => Navigator.of(context).popAndPushNamed(AppRoute.existingMemberPage),
          ),
          const SizedBox(height: AppSize.inset),
          CustomButton(
            title: LocaleKeys.cancel.value,
            onPressed: () => Navigator.of(context).pop(),
          )
        ]),
      );
    },
  );
}
