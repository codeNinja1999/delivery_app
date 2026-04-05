import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';

import 'bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // final bloc = context.read<ProfileBloc>();
    // bloc.add(GetUserData());
    // bloc.add(UserInfoSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppPage.scroll(
      appBar: MyAppBar(
        title: "Profile",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSize.viewMargin),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, UserRoute.editProfile),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                  color: theme.colorScheme.primary,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSize.cornerRadiusMedium, vertical: AppSize.cornerRadiusSmall),
                child: Text(
                  "Edit",
                  style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          status is InProgress ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            AppRouter.logoutUser(context);
          } else if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) => previous.userInfo != current.userInfo,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSize.inset),
                  Row(
                    children: [
                      const Icon(Icons.people),
                      const SizedBox(width: AppSize.inset),
                      Expanded(
                        child: Text(
                          state.userInfo?.personalInfo?.fullName ?? "John doe",
                          style: theme.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.inset),
                  Row(
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: AppSize.inset),
                      Expanded(
                        child: Text(
                          state.userInfo?.personalInfo?.email ?? "johndoe@gmail.com",
                          style: theme.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.inset),
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: AppSize.inset),
                      Expanded(
                        child: Text(
                          state.userInfo?.personalInfo?.phoneNumber ?? "123-345-567",
                          style: theme.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.inset),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: AppSize.inset),
                      Expanded(
                        child: Text(
                          "${state.userInfo?.contactInfo?.address ?? "Naxal, Kkathmandu"} ${state.userInfo?.contactInfo?.houseNumber ?? "34411"}",
                          // "Phuket - Ban Tawan House: 1415 ,Dropbox: 122Beside ABC train station",
                          style: theme.textTheme.titleMedium,
                        ),
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
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: Border.all(color: Theme.of(context).colorScheme.outline),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Total Orders",
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "20",
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSize.inset),
                      Container(
                        padding: const EdgeInsets.all(AppSize.inset),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: Border.all(color: Theme.of(context).colorScheme.outline),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Completed Orders",
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "17",
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.viewSpacing),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(UserRoute.changePassword),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.cornerRadius,
                        vertical: AppSize.cornerRadiusMedium,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium)),
                      side: BorderSide(color: theme.colorScheme.primary),
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      "Change Password",
                      style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
                    ),
                  ),
                  const SizedBox(height: AppSize.inset),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.cornerRadius,
                        vertical: AppSize.cornerRadiusMedium,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium)),
                      side: BorderSide(color: theme.colorScheme.primary),
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (newContext) {
                          return CustomDialog(
                            title: LocaleKeys.logoutConfirmationTitle.value,
                            message: LocaleKeys.areYouSureYouWantToLogout.value,
                            primaryButtonTitle: LocaleKeys.yes.value,
                            onPrimaryButtonPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              // context.read<ProfileBloc>().add(LogoutUser());
                            },
                            secondaryButtonTitle: LocaleKeys.no.value,
                          );
                        },
                      );
                    },
                    child: Text(
                      "Logout",
                      style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
