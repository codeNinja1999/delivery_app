import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../route/app_account_utility_route.dart';
import '../account/widgets/menu_item_view.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: LocaleKeys.helpCenterTitle.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const HelpCenterBody(),
    );
  }
}

class HelpCenterBody extends StatefulWidget {
  const HelpCenterBody({super.key});

  @override
  State<HelpCenterBody> createState() => _HelpCenterBodyState();
}

class _HelpCenterBodyState extends State<HelpCenterBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.inset,
        vertical: AppSize.viewMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuItem(
            title: LocaleKeys.faqs.value,
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(AppAccountUtilityRoute.faq);
            },
          ),
          Divider(height: 1, color: theme.dividerColor),
          MenuItem(
            title: LocaleKeys.customerCareTitle.value,
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(AppAccountUtilityRoute.customerCare);
            },
          ),
          // Divider(height: 1, color: theme.dividerColor),
          // MenuItem(
          //   title: "Report a problem",
          //   onTap: () {
          //     Navigator.of(context, rootNavigator: true)
          //         .pushNamed(AppAccountUtilityRoute.reportAProblem);
          //   },
          // ),
        ],
      ),
    );
  }
}
