import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:flutter/material.dart';

class VerificationRule extends StatefulWidget {
  const VerificationRule({super.key});

  @override
  State<VerificationRule> createState() => _VerificationRuleState();
}

class _VerificationRuleState extends State<VerificationRule> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.viewMargin),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              LocaleKeys.rulesForVerification.value,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: AppSize.inset),
          RulesCard(
            color: const Color(0xFF3FC555),
            title: LocaleKeys.dos.value,
            rule1: LocaleKeys.doRule1.value,
            rule2: LocaleKeys.doRule2.value,
            rule3: LocaleKeys.doRule3.value,
          ),
          const SizedBox(height: AppSize.inset),
          RulesCard(
            color: const Color(0xFFFF0000),
            title: LocaleKeys.doNot.value,
            rule1: LocaleKeys.doNotRule1.value,
            rule2: LocaleKeys.doNotRule2.value,
            rule3: LocaleKeys.doNotRule3.value,
          ),
        ],
      ),
    );
  }
}

class RulesCard extends StatelessWidget {
  const RulesCard({
    super.key,
    required this.title,
    required this.rule1,
    required this.rule2,
    required this.color,
    this.rule3,
  });

  final String title;
  final String rule1;
  final String rule2;
  final String? rule3;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      color: color.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.inset),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: color, size: 30),
                const SizedBox(width: AppSize.cornerRadiusMedium),
                Text(title, style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: AppSize.cornerRadiusMedium),
            Divider(color: AppColors.greyColor),
            UnorderedListItem(rule1),
            UnorderedListItem(rule2),
            (rule3 != null) ? UnorderedListItem(rule3!) : Container(),
          ],
        ),
      ),
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.cornerRadiusSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("•  "),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
