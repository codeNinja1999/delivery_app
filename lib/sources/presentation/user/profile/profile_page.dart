import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: "Profile",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSize.viewMargin),
            child: CustomButton(
                title: "Edit Profile",
                buttonType: ButtonType.bordered,
                onPressed: () {
                  Navigator.pushNamed(context, UserRoute.editProfile);
                }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            children: [
              Icon(Icons.people),
              Text(
                "John doe",
                style: theme.textTheme.titleMedium,
              )
            ],
          ),
          const SizedBox(height: AppSize.inset),
          Row(
            children: [
              Icon(Icons.email),
              Text(
                "johndoe@gmail.com",
                style: theme.textTheme.titleMedium,
              )
            ],
          ),
          const SizedBox(height: AppSize.inset),
          Row(
            children: [
              Icon(Icons.phone),
              Text(
                "123-345-567",
                style: theme.textTheme.titleMedium,
              )
            ],
          ),
          const SizedBox(height: AppSize.inset),
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Icon(Icons.piano),
              Text(
                "Phuket - Ban Tawan House: 1415 ,Dropbox: 122 Beside ABC train station",
                style: theme.textTheme.titleMedium,
              )
            ],
          ),
          const SizedBox(height: AppSize.inset),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSize.inset),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                  color: theme.colorScheme.surfaceContainer,
                ),
                child: Column(
                  children: [
                    Text(
                      "Total Orders",
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "20",
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: AppSize.titleFont),
                    )
                  ],
                ),
              ),
              const SizedBox(width: AppSize.inset),
              Container(
                padding: const EdgeInsets.all(AppSize.inset),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                  color: theme.colorScheme.surfaceContainer,
                ),
                child: Column(
                  children: [
                    Text(
                      "Completed Orders",
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "17",
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: AppSize.titleFont),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.viewSpacing),
          TextButton(
            onPressed: () {},
            child: Text(
              "Change Password",
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
            ),
          ),
          const SizedBox(height: AppSize.inset),
          TextButton(
            onPressed: () {},
            child: Text(
              "Logout",
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
            ),
          ),
        ]),
      ),
    );
  }
}
