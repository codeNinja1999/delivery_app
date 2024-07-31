import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_bar/app_bar.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/button/custom_button.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

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

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(
        title: "Pickup Time",
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Choose your date and time",
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSize.cornerRadiusMedium),
                    Text(
                      "Select  the date and the time for laundry pickup",
                      style: theme.textTheme.bodySmall,
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
                  Navigator.pushNamed(context, UserRoute.checkout);
                }),
          ],
        ),
      ),
    );
  }
}

class _DateSelectionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController();
    return BlocBuilder<DateSelectionBloc, DateSelectionState>(
      buildWhen: (previous, current) => previous.pickupDate != current.pickupDate,
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final datePicked = await openDatePicker(
              context: context,
              minimumYear: 0,
              date: (state.pickupDate != "") ? DateTime.parse(state.pickupDate) : null,
            );
            if (datePicked != null) {
              final dobDate = DateFormat('yyyy-MM-dd').format(datePicked);
              if (context.mounted) {
                context.read<DateSelectionBloc>().add(DateSelected(dobDate));
                dateController.text = dobDate;
              }
            }
          },
          child: AbsorbPointer(
            child: AppTextfield(
              title: "Pickup Date",
              placeHolder: "Select date for pickup",
              suffixIcon: const Icon(Icons.calendar_month),
              controller: dateController,
              validator: (_) => state.dateValidation,
            ),
          ),
        );
      },
    );
  }
}
