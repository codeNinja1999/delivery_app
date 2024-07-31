import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/user/dashboard/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(
        allowBack: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSize.viewMargin),
            child: Row(
              children: [
                NotificationBadge(),
                SizedBox(width: AppSize.inset),
                CircleAvatar(child: Text("FD")),
              ],
            ),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
