import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/beneficiary_detail_bloc.dart';
import 'beneficiary_detail_view.dart';

class BeneficiaryDetailPage extends StatefulWidget {
  const BeneficiaryDetailPage({super.key});

  @override
  State<BeneficiaryDetailPage> createState() => _BeneficiaryDetailPageState();
}

class _BeneficiaryDetailPageState extends State<BeneficiaryDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<BeneficiaryDetailBloc>().add(GetReceiverDetail());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.beneficiaryTitle.value),
      body: BlocListener<BeneficiaryDetailBloc, BeneficiaryDetailState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is BeneficiaryDelSuccess) {
            Navigator.pop(context);
          } else if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: const BeneficiaryDetailView(),
      ),
    );
  }
}
