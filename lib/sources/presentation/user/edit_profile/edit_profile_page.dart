import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            "About you".toUpperCase(),
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Full Name",
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Email Address Name",
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Phone Number",
          ),
          const SizedBox(height: AppSize.viewSpacing),
          Text(
            "Address".toUpperCase(),
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Address",
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "House Number",
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Dropbox Number",
          ),
          const SizedBox(height: AppSize.viewSpacing),
          CustomButton(
              title: "Update",
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ]),
      ),
    );
  }
}
