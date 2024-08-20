import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_bar/app_bar.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_dropdown/app_dropdown.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/button/custom_button.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/textfield/app_textfield.dart';

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
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(
        title: "Add New Location",
      ),
      body: SingleChildScrollView(
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
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
