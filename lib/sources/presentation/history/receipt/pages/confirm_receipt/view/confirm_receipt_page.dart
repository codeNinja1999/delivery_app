import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'confirm_receipt_body.dart';

class ConfirmReceiptPage extends StatefulWidget {
  const ConfirmReceiptPage({super.key});

  @override
  State<ConfirmReceiptPage> createState() => _ConfirmReceiptPageState();
}

class _ConfirmReceiptPageState extends State<ConfirmReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.uploadReceiptTitle.value),
      body: const ConfirmReceiptBody(),
    );
  }
}
