import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

import '../../../route/app_account_utility_route.dart';
import '../bloc/account_bloc.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        final String name = state.userInfo?.personalInfo.fullName ?? "Guest";
        return GestureDetector(
          onDoubleTap: null,
          onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(AppAccountUtilityRoute.profile),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              border: Border.all(color: theme.colorScheme.tertiary, width: 1),
              borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    (state.userInfo?.userImage?.customerProfileImage != null)
                        ? CircleAvatar(
                            radius: 25.0,
                            backgroundColor: theme.colorScheme.tertiary,
                            backgroundImage: NetworkImage(state.userInfo?.userImage?.customerProfileImage ?? ""),
                          )
                        : const CircleAvatar(
                            radius: 25.0,
                            child: Icon(
                              Icons.account_circle,
                              size: 50,
                            ),
                          ),
                    const SizedBox(width: AppSize.inset),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(name, style: theme.textTheme.titleMedium),
                            const SizedBox(width: AppSize.inset * 0.5),
                            Text(state.userInfo?.userName ?? "", style: theme.textTheme.bodyMedium)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.inset),
                    SvgPicture.asset(AppSvg.arrowForward, height: AppSize.inset)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
