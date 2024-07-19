import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class ProfileItemHeader extends StatelessWidget {
  const ProfileItemHeader({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        title ?? '-------------',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class UserPersonalInfoItemView extends StatelessWidget {
  const UserPersonalInfoItemView({
    super.key,
    this.title,
    this.value,
    this.description,
  });

  final String? title;
  final String? value;
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title ?? "-----",
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: AppSize.cornerRadiusSmall),
        Text(value ?? '----------', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: AppSize.inset),
      ],
    );
  }
}
