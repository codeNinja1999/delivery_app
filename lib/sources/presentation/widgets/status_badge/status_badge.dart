import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class TransactionStatusColorMappingView extends StatelessWidget {
  const TransactionStatusColorMappingView({super.key, this.transactionStatus});
  final TransactionStatus? transactionStatus;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        switch (transactionStatus?.type) {
          case TransactionType.hold:
          case TransactionType.post:
            return StatusWidget(status: transactionStatus?.value ?? "", statusColor: AppColors.hold);

          case TransactionType.cancelled:
          case TransactionType.error:
            return StatusWidget(status: transactionStatus?.value ?? "", statusColor: AppColors.cancelled);

          case TransactionType.paymentReview:
          case TransactionType.pendingPayment:
          case TransactionType.unknown:
            return StatusWidget(status: transactionStatus?.value ?? "", statusColor: AppColors.pending);

          case TransactionType.paid:
            return StatusWidget(status: transactionStatus?.value ?? "", statusColor: AppColors.success);

          default:
            return StatusWidget(status: transactionStatus?.value ?? "", statusColor: AppColors.hold);
        }
      },
    );
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, required this.status, required this.statusColor});

  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.inset),
        color: statusColor,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.cornerRadiusMedium,
        vertical: AppSize.cornerRadiusSmall / 2,
      ),
      child: Text(
        status,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: (statusColor == AppColors.pending) ? AppColors.black : AppColors.whiteColor),
      ),
    );
  }
}
