import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../set_pin/bloc/set_pin_bloc.dart';

class ConfirmTransactionPinPage extends StatefulWidget {
  const ConfirmTransactionPinPage({super.key});

  @override
  State<ConfirmTransactionPinPage> createState() => _ConfirmTransactionPinState();
}

class _ConfirmTransactionPinState extends State<ConfirmTransactionPinPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyAppBar(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: theme.disabledColor),
          BlocBuilder<SetPinBloc, SetPinState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.viewMargin,
                  horizontal: AppSize.inset,
                ),
                child: CustomButton(
                  title: LocaleKeys.submit.value,
                  onPressed: () {
                    KeyboardUtil.hideKeyboard(context);
                    // if (_formKey.currentState!.validate()) {
                    //   context.read<UserVerifyBloc>().add(VerifyUser());
                    // }
                  },
                  buttonType: ButtonType.round,
                ),
              );
            },
          ),
        ],
      ),
      body: const ConfirmPinBody(),
    );
  }
}

class ConfirmPinBody extends StatefulWidget {
  const ConfirmPinBody({super.key});

  @override
  State<ConfirmPinBody> createState() => _ConfirmPinBodyState();
}

class _ConfirmPinBodyState extends State<ConfirmPinBody> {
  var formKey = GlobalKey<FormState>();
  String code = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SetPinBloc, SetPinState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.viewMargin,
            horizontal: AppSize.inset,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.inset),
                  child: Text(
                    LocaleKeys.setupTransactionPin.value,
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: 36),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.viewSpacing,
                    bottom: AppSize.inset,
                  ),
                  child: Text(
                    LocaleKeys.confirmTransactionPin.value,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                const OtpNumberBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
