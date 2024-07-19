import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../../route/app_account_utility_route.dart';
import '../bloc/account_bloc.dart';
import '../widgets/widgets.dart';

class AccountMenuListView extends StatelessWidget {
  const AccountMenuListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AccountBloc, AccountState>(
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const UserInformation(),
                const SizedBox(height: AppSize.inset),
                MenuItem(
                  title: LocaleKeys.notifications.value,
                  leadingWidget: SvgPicture.asset(AppSvg.notification, height: 20, width: 20),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(AppAccountUtilityRoute.notificationSetup);
                  },
                ),
                Divider(height: 1, color: theme.dividerColor),
                BlocBuilder<AccountBloc, AccountState>(
                  buildWhen: (previous, current) => previous.userInfo != current.userInfo,
                  builder: (context, state) {
                    return MenuItem(
                      leadingWidget: SvgPicture.asset(AppSvg.report),
                      title: LocaleKeys.kycStatus.value,
                      trailingWidget: Container(),
                      secondaryWidget: KycStatusBadge(status: state.userInfo?.status ?? KYCStatus.partial),
                    );
                  },
                ),
                Divider(height: 1, color: theme.dividerColor),
                MenuItem(
                  leadingWidget: SvgPicture.asset(AppSvg.languageSvg),
                  title: LocaleKeys.language.value,
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(AppAccountUtilityRoute.changeLanguage);
                  },
                  secondaryWidget: Padding(
                    padding: const EdgeInsets.only(right: AppSize.inset),
                    child: Text(
                      StringUtils.getCountryName(context.locale.countryCode ?? ""),
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Divider(height: 1, color: theme.dividerColor),
                MenuItem(
                  title: LocaleKeys.helpCenterTitle.value,
                  leadingWidget: SvgPicture.asset(AppSvg.alert),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(AppAccountUtilityRoute.helpCenter);
                  },
                ),
                Divider(height: 1, color: theme.dividerColor),
                MenuItem(
                  title: LocaleKeys.changePassword.value,
                  leadingWidget: const Icon(
                    Icons.password,
                    size: AppSize.viewSpacing * 0.75,
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(AppAccountUtilityRoute.changePassword);
                  },
                ),
                Divider(height: 1, color: theme.dividerColor),
                MenuItem(
                  title: LocaleKeys.logout.value,
                  leadingWidget: SvgPicture.asset(AppSvg.logout),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (newContext) {
                        return CustomDialog(
                          title: LocaleKeys.logoutConfirmationTitle.value,
                          message: LocaleKeys.areYouSureYouWantToLogout.value,
                          primaryButtonTitle: LocaleKeys.yes.value,
                          onPrimaryButtonPressed: () => context.read<AccountBloc>().add(LogoutUser()),
                          secondaryButtonTitle: LocaleKeys.no.value,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
