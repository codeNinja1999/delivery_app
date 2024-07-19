import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class ReceiverListHeaderView extends StatelessWidget {
  const ReceiverListHeaderView({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.inset),
      child: Text(title ?? "", style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
