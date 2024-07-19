import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'verify_number_form.dart';

class VerifyNumberPage extends StatefulWidget {
  const VerifyNumberPage({super.key});

  @override
  State<VerifyNumberPage> createState() => _VerifyNumberPageState();
}

class _VerifyNumberPageState extends State<VerifyNumberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(backButtonAction: () => Navigator.of(context, rootNavigator: true).pop()),
      body: const VerifyNumberForm(),
    );
  }
}
