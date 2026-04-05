import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';

import 'bloc/operator_profile_bloc.dart';

class OperatorProfilePage extends StatefulWidget {
  const OperatorProfilePage({super.key});

  @override
  State<OperatorProfilePage> createState() => _OperatorProfilePageState();
}

class _OperatorProfilePageState extends State<OperatorProfilePage> {
  @override
  void initState() {
    super.initState();
    // context.read<OperatorProfileBloc>().add(GetOperatorInfo());
    // context.read<OperatorProfileBloc>().add(OperatorInfoSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppPage.scroll(
      appBar: const MyAppBar(
        title: "Profile",
      ),
      body: BlocListener<OperatorProfileBloc, OperatorProfileState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          status is InProgress ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            AppRouter.logoutUser(context);
          }
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: BlocBuilder<OperatorProfileBloc, OperatorProfileState>(
          buildWhen: (previous, current) => previous.operatorInfo != current.operatorInfo,
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
                          state.operatorInfo?.personalInfo?.fullName ?? "operator",
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
                          state.operatorInfo?.personalInfo?.email ?? "operator@gmail.com",
                          style: theme.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.spacedViewSpacing),
                  Center(
                    child: SizedBox(
                      width: 100,
                      child: CustomButton(
                        title: "Logout",
                        buttonType: ButtonType.bordered,
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
// context.read<OperatorProfileBloc>().add(LogoutUser());
                                },
                                secondaryButtonTitle: LocaleKeys.no.value,
                              );
                            },
                          );
                        },
                      ),
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
