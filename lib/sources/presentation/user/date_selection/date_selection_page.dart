import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../bloc/user_bloc.dart';
import 'bloc/date_selection_bloc.dart';

class DateSelectionPage extends StatefulWidget {
  const DateSelectionPage({super.key});

  @override
  State<DateSelectionPage> createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPage(
      appBar: const MyAppBar(
        title: "Pickup Time",
      ),
      body: BlocListener<DateSelectionBloc, DateSelectionState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            context.read<UserBloc>().add(SavePickupDate(state.pickupDate));
            Navigator.pushNamed(context, UserRoute.checkout);
          }
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: context.hInset,
            right: context.hInsetR,
            bottom: AppSize.bottomSafeInset,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.inset),
                      Text(
                        "Choose your date and time",
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSize.inset * 0.5),
                      Text(
                        "Select  the date and the time for laundry pickup",
                      ),
                      const SizedBox(height: AppSize.viewSpacing),
                      _DateSelectionInput(),
                    ],
                  ),
                ),
              ),
              CustomButton(
                title: "Save and Continue",
                onPressed: () {
                  // context.read<DateSelectionBloc>().add(ValidateDate());
                  Navigator.pushNamed(context, UserRoute.checkout);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateSelectionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateSelectionBloc, DateSelectionState>(
      buildWhen: (previous, current) =>
          previous.pickupDate != current.pickupDate || previous.pickupDateView != current.pickupDateView,
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            // final datePicked = await openDatePicker(
            //   context: context,
            //   date: (state.pickupDateView != "") ? DateTime.parse(state.pickupDateView) : null,
            // );
            final datePicked = await openCupertinoDatePicker(
              context: context,
              type: PickerType.expiryDate,
              selectedDate: (state.pickupDateView != "") ? DateFormat('yyyy-MM-dd').parse(state.pickupDateView) : null,
            );
            if (datePicked != null) {
              if (context.mounted) {
                context.read<DateSelectionBloc>().add(DateSelected(datePicked));
              }
            }
          },
          child: AbsorbPointer(
            child: AppTextfield(
              title: "Pickup Date",
              placeHolder: "Select date for pickup",
              suffixIcon: const Icon(Icons.calendar_month),
              controller: TextEditingController()..text = state.pickupDateView,
              validator: (_) => state.dateValidation,
            ),
          ),
        );
      },
    );
  }
}
