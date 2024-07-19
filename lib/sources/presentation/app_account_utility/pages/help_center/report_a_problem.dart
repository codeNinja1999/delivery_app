import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class ReportAProblemPage extends StatefulWidget {
  const ReportAProblemPage({super.key});

  @override
  State<ReportAProblemPage> createState() => _ReportAProblemPageState();
}

class _ReportAProblemPageState extends State<ReportAProblemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "Report a problem",
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.inset,
          vertical: AppSize.viewMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TitleInput(),
            const SizedBox(height: AppSize.inset),
            const IssueDescriptionInput(),
            const SizedBox(height: AppSize.viewSpacing),
            CustomButton(onPressed: () {}, title: "Submit"),
          ],
        ),
      ),
    );
  }
}

class TitleInput extends StatelessWidget {
  const TitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextfield(
      textInputType: TextInputType.text,
      title: "Title",
      placeHolder: "What is your issue?",
      onChanged: (title) {},
    );
  }
}

class IssueDescriptionInput extends StatelessWidget {
  const IssueDescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextfield(
      maxLine: 5,
      textInputType: TextInputType.multiline,
      title: "Issue Description",
      placeHolder: "Please provide a short description...",
      onChanged: (description) {},
    );
  }
}
