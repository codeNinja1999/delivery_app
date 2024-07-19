import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: LocaleKeys.notification.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      body: const NotificationBody(),
    );
  }
}

class NotificationBody extends StatefulWidget {
  const NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  bool _switchValueT = false;
  bool _switchValueP = false;
  bool _switchValueU = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSize.viewMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Transaction status", style: theme.textTheme.titleMedium),
            trailing: CustomSwitch(
              value: _switchValueT,
              onChanged: (bool val) {
                setState(() {
                  _switchValueT = val;
                });
              },
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Promo", style: theme.textTheme.titleMedium),
            trailing: CustomSwitch(
              value: _switchValueP,
              onChanged: (bool val) {
                setState(() {
                  _switchValueP = val;
                });
              },
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Updates", style: theme.textTheme.titleMedium),
            trailing: CustomSwitch(
              value: _switchValueU,
              onChanged: (bool val) {
                setState(() {
                  _switchValueU = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
