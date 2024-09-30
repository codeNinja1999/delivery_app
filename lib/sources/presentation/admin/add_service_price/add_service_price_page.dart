import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

import 'bloc/add_service_price_bloc.dart';

class AddServicePricePage extends StatelessWidget {
  const AddServicePricePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const MyAppBar(
        title: "Add Price",
      ),
      backgroundColor: theme.colorScheme.surface,
      body: BlocListener<AddServicePriceBloc, AddServicePriceState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextfield(title: "Service Type"),
              AppTextfield(title: "Price"),
              const SizedBox(height: AppSize.viewSpacing),
              BlocBuilder<AddServicePriceBloc, AddServicePriceState>(
                builder: (context, state) {
                  return CustomButton(
                      backgroundColor: AppColors.primary,
                      title: "Save Service",
                      onPressed: () {
                        context.read<AddServicePriceBloc>().add(SubmitService(state.makeData()));
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
