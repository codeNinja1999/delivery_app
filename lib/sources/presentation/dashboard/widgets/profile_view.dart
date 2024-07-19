import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

import '../bloc/dashboard_bloc.dart';
import 'notification_badge.dart';

String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  if (hour < 12) {
    return LocaleKeys.goodMorning.value;
  } else if (hour < 18) {
    return LocaleKeys.goodAfternoon.value;
  } else {
    return LocaleKeys.goodEvening.value;
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => previous.userInfo != current.userInfo,
      builder: (context, state) {
        final profileImage =
            state.userInfo?.userImage?.customerProfileImage ?? state.userInfo?.userImage?.customerSelfieImage;
        return Padding(
          padding: const EdgeInsets.only(
            top: AppSize.inset,
            left: AppSize.viewMargin,
            right: AppSize.viewMargin,
          ),
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NotificationBadge(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: (profileImage != null)
                            ? Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.tertiary,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(profileImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: FittedBox(
                                  child: Icon(
                                    Icons.account_circle,
                                    color: theme.colorScheme.surface,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: AppSize.cornerRadiusMedium),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              getGreeting(),
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(width: AppSize.inset * 0.125),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      state.userInfo?.personalInfo.fullName ?? "Guest",
                                      maxLines: 2,
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  const SizedBox(width: AppSize.inset * 0.25),
                                  Visibility(
                                    visible: state.userInfo?.status == KYCStatus.verified,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: AppSize.cornerRadiusMedium * 0.75),
                                      child: SvgPicture.asset(AppSvg.verified, height: AppSize.inset),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.cornerRadiusMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}
