import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/check_rate_bloc.dart';
import 'check_rate_view.dart';

class CheckRatePage extends StatefulWidget {
  const CheckRatePage({super.key});

  @override
  State<CheckRatePage> createState() => _CheckRatePageState();
}

class _CheckRatePageState extends State<CheckRatePage> {
  @override
  void initState() {
    super.initState();
    context.read<CheckRateBloc>().add(GetCountry());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.checkRate.value),
      body: const CheckRateView(),
    );
  }
}
