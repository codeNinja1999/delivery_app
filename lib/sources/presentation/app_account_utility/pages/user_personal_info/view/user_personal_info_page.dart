import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/kyc_status.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../bloc/user_personal_info_bloc.dart';
import 'user_personal_info_item_view.dart';

class UserPersonalInfoPage extends StatefulWidget {
  const UserPersonalInfoPage({super.key});

  @override
  State<UserPersonalInfoPage> createState() => _UserPersonalInfoPageState();
}

class _UserPersonalInfoPageState extends State<UserPersonalInfoPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserPersonalInfoBloc>().add(UserInfoSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: LocaleKeys.profileTitle.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      body: const UserPersonalInfoBody(),
    );
  }
}

class UserPersonalInfoBody extends StatefulWidget {
  const UserPersonalInfoBody({super.key});

  @override
  State<UserPersonalInfoBody> createState() => _UserPersonalInfoBodyState();
}

class _UserPersonalInfoBodyState extends State<UserPersonalInfoBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UserPersonalInfoBloc, UserPersonalInfoState>(
      buildWhen: (previous, current) => previous.personalInfoViewModel != current.personalInfoViewModel,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSize.viewMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const UserPersonalProfileImage(),
              const SizedBox(height: AppSize.spacedViewSpacing),
              Text(
                LocaleKeys.personalDetails.value.toUpperCase(),
                style: theme.textTheme.labelLarge?.copyWith(
                  letterSpacing: 2.2,
                  color: theme.primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.cornerRadiusSmall * 2),
                child: Divider(thickness: 1, color: theme.dividerColor),
              ),
              UserPersonalInfoItemView(
                title: LocaleKeys.fullName.value,
                value: state.personalInfoViewModel?.fullName,
              ),
              UserPersonalInfoItemView(
                title: LocaleKeys.phoneNumberTitle.value,
                value: state.personalInfoViewModel?.mobileNumber,
              ),
              UserPersonalInfoItemView(
                title: LocaleKeys.emailAddressTitle.value,
                value: state.personalInfoViewModel?.emailAddress,
              ),
              UserPersonalInfoItemView(
                title: LocaleKeys.nationality.value,
                value: state.personalInfoViewModel?.nationality,
              ),
              UserPersonalInfoItemView(
                title: LocaleKeys.dateOfBirthLabel.value,
                value: state.personalInfoViewModel?.dob,
              ),
              UserPersonalInfoItemView(
                title: LocaleKeys.gender.value,
                value: state.personalInfoViewModel?.gender,
              ),
              const SizedBox(height: AppSize.inset),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.addressDetailTitle.value.toUpperCase(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      letterSpacing: 2.2,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: theme.dividerColor),
              const SizedBox(height: AppSize.inset),
              UserPersonalInfoItemView(
                title: LocaleKeys.country.value,
                value: state.personalInfoViewModel?.country,
              ),
              UserPersonalInfoItemView(
                title: LocaleKeys.state.value,
                value: state.personalInfoViewModel?.state,
              ),
              if (state.personalInfoViewModel?.city != null)
                UserPersonalInfoItemView(
                  title: LocaleKeys.cityLabel.value,
                  value: state.personalInfoViewModel?.city,
                ),
              UserPersonalInfoItemView(
                title: LocaleKeys.addressLabel.value,
                value: state.personalInfoViewModel?.address,
              ),
              UserPersonalInfoItemView(
                title: LocaleKeys.zipCodeLabel.value,
                value: state.personalInfoViewModel?.zipCode,
              ),
              const SizedBox(height: AppSize.inset),
              (state.personalInfoViewModel?.status == KYCStatus.verified)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          LocaleKeys.idDetailsTitle.value.toUpperCase(),
                          style: theme.textTheme.labelLarge?.copyWith(
                            letterSpacing: 2.2,
                            color: theme.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSize.inset),
                          child: Divider(
                            thickness: 1,
                            color: theme.dividerColor,
                          ),
                        ),
                        UserPersonalInfoItemView(
                          title: LocaleKeys.idType.value,
                          value: state.personalInfoViewModel?.idType,
                        ),
                        UserPersonalInfoItemView(
                          title: LocaleKeys.idNumber.value,
                          value: state.personalInfoViewModel?.idNumber,
                        ),
                        UserPersonalInfoItemView(
                          title: LocaleKeys.issueCountry.value,
                          value: state.personalInfoViewModel?.issueCountry,
                        ),
                        UserPersonalInfoItemView(
                          title: LocaleKeys.issueDate.value,
                          value: state.personalInfoViewModel?.issueDate,
                        ),
                        UserPersonalInfoItemView(
                          title: LocaleKeys.expiryDate.value,
                          value: state.personalInfoViewModel?.expiryDate,
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: AppSize.viewMargin),
            ],
          ),
        );
      },
    );
  }
}

class UserPersonalProfileImage extends StatelessWidget {
  const UserPersonalProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UserPersonalInfoBloc, UserPersonalInfoState>(
      buildWhen: (previous, current) => previous.personalInfoViewModel != current.personalInfoViewModel,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: (state.personalInfoViewModel?.profileImageUrl != null)
                  ? CircleAvatar(
                      radius: 40.0,
                      backgroundColor: theme.colorScheme.tertiary,
                      backgroundImage: NetworkImage(state.personalInfoViewModel?.profileImageUrl ?? ""),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: BorderImage(
                          imageUrl: state.personalInfoViewModel?.flag ?? AppConstants.defaultFlagUrl,
                          size: AppSize.viewSpacing,
                        ),
                      ),
                    )
                  : const CircleAvatar(
                      radius: 40,
                      child: Center(child: Icon(Icons.account_circle, size: 80)),
                    ),
            ),
            const SizedBox(height: AppSize.cornerRadiusMedium),
            Text(
              state.personalInfoViewModel?.fullName ?? "",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSize.cornerRadiusSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.kycStatus.value,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: AppSize.cornerRadiusMedium),
                KycStatusBadge(status: state.personalInfoViewModel?.status ?? KYCStatus.partial)
              ],
            ),
          ],
        );
      },
    );
  }
}

class EditButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xff3045B3),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSize.inset,
          0,
          AppSize.inset,
          0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.edit,
              size: AppSize.inset,
            ),
            const SizedBox(
              width: AppSize.cornerRadiusSmall,
            ),
            Text(
              LocaleKeys.editDetail.value,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
