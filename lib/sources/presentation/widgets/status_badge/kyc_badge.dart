import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class KycStatusBadge extends StatelessWidget {
  const KycStatusBadge({super.key, required this.status});

  final KYCStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.inset),
        color: status.color,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.cornerRadiusMedium,
        vertical: AppSize.cornerRadiusSmall,
      ),
      child: Text(
        status.value,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: status.textColor),
      ),
    );
  }
}
