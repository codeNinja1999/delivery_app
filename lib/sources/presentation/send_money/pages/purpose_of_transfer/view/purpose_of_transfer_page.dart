import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/send_money_bloc.dart';
import '../../../route/send_money_route.dart';
import '../bloc/purpose_of_transfer_bloc.dart';
import 'purpose_of_transfer_form.dart';

class PurposeOfTransferPage extends StatefulWidget {
  const PurposeOfTransferPage({super.key});

  @override
  State<PurposeOfTransferPage> createState() => _PurposeOfTransferPageState();
}

class _PurposeOfTransferPageState extends State<PurposeOfTransferPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<PurposeOfTransferBloc>();
    bloc.add(GetCatalog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.sendMoney.value),
      body: BlocListener<PurposeOfTransferBloc, PurposeOfTransferState>(
        listener: (context, state) {
          final status = state.status;
          status is InProgress ? LoadingView.show() : LoadingView.hide();
          if (status is Success && state.createTransactionResult != null) {
            context
                .read<SendMoneyBloc>()
                .add(SaveCreatedTransactionResult(createdTransactionResult: state.createTransactionResult));
            Navigator.of(context).pushNamed(SendMoneyRoute.confirmDetails);
          } else if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const ProgressIndicatorView(currentStep: 2),
            ];
          },
          body: const PurposeOfTransferForm(),
        ),
      ),
    );
  }
}
