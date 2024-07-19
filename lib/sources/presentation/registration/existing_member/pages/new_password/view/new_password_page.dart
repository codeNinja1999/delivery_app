import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/new_password_bloc.dart';
import 'new_password_form.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewPasswordBloc>().add(IsSkipChanged());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) => previous.isSkip != current.isSkip,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: MyAppBar(
            backButtonAction: state.isSkip ? Navigator.of(context).pop : cancelRegistration,
          ),
          body: const NewPasswordForm(),
        );
      },
    );
  }

  void cancelRegistration() {
    showDialog(
      context: context,
      builder: (newContext) {
        return CustomDialog(
          svgImage: AppSvg.cancel,
          title: LocaleKeys.cancel.value,
          message: LocaleKeys.areYouSureYouWantToCancel.value,
          primaryButtonTitle: LocaleKeys.yesCancel.value,
          secondaryButtonTitle: LocaleKeys.noIWantToContinue.value,
          onPrimaryButtonPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        );
      },
    );
  }
}
