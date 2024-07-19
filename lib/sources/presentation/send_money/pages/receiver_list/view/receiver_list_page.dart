import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'receiver_list_body.dart';

class ReceiverListPage extends StatefulWidget {
  final Function(void) onCreateBeneficiary;
  const ReceiverListPage({super.key, required this.onCreateBeneficiary});

  @override
  State<ReceiverListPage> createState() => _ReceiverListState();
}

class _ReceiverListState extends State<ReceiverListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.sendMoney.value),
      body: ReceiverListBody(onCreateBeneficiary: widget.onCreateBeneficiary),
    );
  }
}
