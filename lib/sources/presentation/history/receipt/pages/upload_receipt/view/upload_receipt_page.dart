import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'upload_receipt_body.dart';

class UploadReceiptPage extends StatefulWidget {
  const UploadReceiptPage({super.key});

  @override
  State<UploadReceiptPage> createState() => _UploadReceiptPageState();
}

class _UploadReceiptPageState extends State<UploadReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.uploadReceiptTitle.value),
      body: const UploadReceiptBody(),
    );
  }
}
