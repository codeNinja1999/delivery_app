import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/send_money_bloc.dart';
import '../../../route/send_money_route.dart';
import '../bloc/confirm_details_bloc.dart';
import 'confirm_details_view.dart';

class ConfirmDetailsPage extends StatefulWidget {
  const ConfirmDetailsPage({super.key});

  @override
  State<ConfirmDetailsPage> createState() => _ConfirmDetailsPageState();
}

class _ConfirmDetailsPageState extends State<ConfirmDetailsPage> {
  @override
  void initState() {
    super.initState();
    final mainState = context.read<SendMoneyBloc>().state;
    context.read<ConfirmDetailsBloc>().add(GetCreateTransactionResult(mainState.createdTransactionResult));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: LocaleKeys.sendMoney.value,
        backButtonAction: cancelTransactionDialog,
      ),
      body: const ConfirmDetailBody(),
    );
  }

  void cancelTransactionDialog() {
    showDialog(
      context: context,
      builder: (newContext) {
        return CustomDialog(
          svgImage: AppSvg.cancel,
          title: LocaleKeys.cancelTransaction.value,
          message: LocaleKeys.areYouSureYouWantToCancelThisTransaction.value,
          primaryButtonTitle: LocaleKeys.yesCancel.value,
          secondaryButtonTitle: LocaleKeys.noIWantToContinue.value,
          onPrimaryButtonPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        );
      },
    );
  }
}

class ConfirmDetailBody extends StatefulWidget {
  const ConfirmDetailBody({super.key});

  @override
  State<ConfirmDetailBody> createState() => _ConfirmDetailBodyState();
}

class _ConfirmDetailBodyState extends State<ConfirmDetailBody> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfirmDetailsBloc, ConfirmDetailsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success && state.confirmTransactionResult != null) {
          context.read<SendMoneyBloc>().add(SaveConfirmTransactionResult(state.confirmTransactionResult));
          Navigator.pushNamed(context, SendMoneyRoute.success);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const ProgressIndicatorView(currentStep: 3),
          ];
        },
        body: const ConfirmDetailsView(),
      ),
    );
  }
}
