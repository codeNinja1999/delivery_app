import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';

import 'bloc/profile_bloc.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminProfileBloc>().add(GetAdminInfo());
    context.read<AdminProfileBloc>().add(AdminInfoSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(
        title: "Profile",
      ),
      body: BlocListener<AdminProfileBloc, AdminProfileState>(
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
        child: BlocBuilder<AdminProfileBloc, AdminProfileState>(
          buildWhen: (previous, current) => previous.adminInfo != current.adminInfo,
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSize.viewMargin),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const SizedBox(height: AppSize.inset),
                Row(
                  children: [
                    const Icon(Icons.people),
                    const SizedBox(width: AppSize.inset),
                    Expanded(
                      child: Text(
                        state.adminInfo?.personalInfo?.userName ?? "",
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
                        state.adminInfo?.personalInfo?.email ?? "",
                        style: theme.textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: AppSize.spacedViewSpacing),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (newContext) {
                        return CustomDialog(
                          title: LocaleKeys.logoutConfirmationTitle.value,
                          message: LocaleKeys.areYouSureYouWantToLogout.value,
                          primaryButtonTitle: LocaleKeys.yes.value,
                          onPrimaryButtonPressed: () => context.read<AdminProfileBloc>().add(LogoutUser()),
                          secondaryButtonTitle: LocaleKeys.no.value,
                        );
                      },
                    );
                  },
                  child: Text(
                    "Logout",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
