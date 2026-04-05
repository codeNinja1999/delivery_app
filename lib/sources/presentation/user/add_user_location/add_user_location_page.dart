import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_bar/app_bar.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_dropdown/app_dropdown.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/button/custom_button.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/progress/loading_view.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/textfield/app_textfield.dart';

import 'bloc/add_user_location_bloc.dart';

class AddUserLocationPage extends StatefulWidget {
  const AddUserLocationPage({super.key});

  @override
  State<AddUserLocationPage> createState() => _AddUserLocationPageState();
}

class _AddUserLocationPageState extends State<AddUserLocationPage> {
  final a = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const MyAppBar(
        title: "Add New Location",
      ),
      body: BlocListener<AddUserLocationBloc, AddUserLocationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            Navigator.pop(context, true);
          } else if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSize.viewMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppDropDown(
                title: "State",
                placeholder: "Select state",
                items: [],
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(height: AppSize.inset),
              AppDropDown(
                title: "Neighborhood",
                placeholder: "Select neighborhood",
                items: [],
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(height: AppSize.inset),
              AppTextfield(
                title: "Unit Number",
                placeHolder: "Enter unit number",
              ),
              const SizedBox(height: AppSize.inset),
              AppTextfield(
                title: "Unit Number",
                placeHolder: "Enter unit number",
              ),
              const SizedBox(height: AppSize.inset),
              AppTextfield(
                title: "Dropbox Number (For Apartments)",
                placeHolder: "Enter unit number",
              ),
              const SizedBox(height: AppSize.inset),
              AppTextfield(
                title: "Additional Instruction (Optional)",
                placeHolder: "Enter additional instruction",
              ),
              const SizedBox(height: AppSize.inset),
              AppTextfield(
                title: "Phone Number",
                placeHolder: "Enter phone number",
              ),
              const SizedBox(height: AppSize.viewSpacing),
              CustomButton(
                title: "Save and Continue",
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
