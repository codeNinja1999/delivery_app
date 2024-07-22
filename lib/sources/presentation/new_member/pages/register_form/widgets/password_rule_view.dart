import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/register_form_bloc.dart';

class PasswordRulView extends StatelessWidget {
  const PasswordRulView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      builder: (context, state) {
        return Wrap(
          children: [
            Text(LocaleKeys.rulesForPassword.value, style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSize.viewSpacing),
            ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle_rounded,
                  color: state.isEightCharacterValid && state.isUpperCaseValid ? Colors.green : null),
              title: Text(
                LocaleKeys.passwordRule1.value,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle_rounded, color: state.isNumericalValueValid ? Colors.green : null),
              title: Text(
                LocaleKeys.passwordRule2.value,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ],
        );
      },
    );
  }
}
