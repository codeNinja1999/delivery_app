import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_bar/app_bar.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_dropdown/app_dropdown.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/button/custom_button.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/textfield/app_textfield.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final a = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const MyAppBar(
        title: "Location Selection",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Choose your Location",
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSize.cornerRadiusMedium),
                  Text(
                    "Where do you like your laundry picked up?",
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSize.inset),
                  ListTile(
                    tileColor: theme.colorScheme.surfaceContainer,
                    contentPadding: const EdgeInsets.all(AppSize.inset),
                    leading: Radio(value: a, groupValue: a, onChanged: (value) {}),
                    title: Text(
                      "Phuket, Ban Tawan, 1415 Unit",
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "Near ABC Bus Stand",
                      style: theme.textTheme.titleSmall,
                    ),
                    trailing: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                    onTap: () => addAddressDialog(),
                  ),
                  const SizedBox(height: AppSize.inset),
                  ListTile(
                    tileColor: theme.colorScheme.surfaceContainer,
                    contentPadding: const EdgeInsets.all(AppSize.inset),
                    title: Text(
                      "Add different address",
                      style: theme.textTheme.titleMedium,
                    ),
                    trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  ),
                ],
              ),
            ),
            CustomButton(title: "Save and Continue", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  addAddressDialog() {
    return showModalBottomSheet(
      context: context,
      builder: (newContext) {
        final theme = Theme.of(context);
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add new address",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  color: theme.colorScheme.primary,
                ),
              ),
              AppDropDown(
                title: "State",
                placeholder: "Select state",
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(height: AppSize.inset),
              AppDropDown(
                title: "Neighborhood",
                placeholder: "Select neighborhood",
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
                    Navigator.pushNamed(context, UserRoute.serviceSelection);
                  }),
            ],
          ),
        );
      },
    );
  }
}
