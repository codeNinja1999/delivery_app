import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/existing_member_bloc.dart';
import '../../../route/existing_member_route.dart';
import '../bloc/selfie_bloc.dart';

class ConfirmSelfiePage extends StatefulWidget {
  const ConfirmSelfiePage({super.key});

  @override
  State<ConfirmSelfiePage> createState() => _ConfirmSelfiePageState();
}

class _ConfirmSelfiePageState extends State<ConfirmSelfiePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(),
      body: BlocListener<SelfieBloc, SelfieState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            context.read<ExistingMemberBloc>().add(SaveSelfieImage(state.selfieImageName));
            Navigator.pushNamed(context, ExistingMemberRoute.verifyEmail);
          } else if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.viewMargin,
                  vertical: AppSize.viewSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.yourUploadedSelfie.value,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSize.inset),
                    Text(
                      LocaleKeys.reviewSelfieBeforeUploading.value,
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: AppSize.viewSpacing),
                    BlocBuilder<ExistingMemberBloc, ExistingMemberState>(
                      buildWhen: (previous, current) => previous.selfieImage != current.selfieImage,
                      builder: (context, state) {
                        final estimatedWidth = MediaQuery.of(context).size.width;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.inset),
                          child: (state.selfieImage != null)
                              ? Image.file(
                                  state.selfieImage!,
                                  height: estimatedWidth * 0.6,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AppImages.selfie,
                                  height: estimatedWidth * 0.6,
                                  fit: BoxFit.cover,
                                ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.viewMargin),
                  ],
                ),
              ),
            ),
            DividerButton(
                backTitle: LocaleKeys.reTake.value,
                nextTitle: LocaleKeys.nextButtonTitle.value,
                backButtonAction: () {
                  context.read<ExistingMemberBloc>().add(GetLocalImage(ScanType.selfie, ScanBy.camera));
                  Future.delayed(const Duration(seconds: 2), () => Navigator.of(context).pop());
                },
                nextButtonAction: () {
                  // Navigator.pushNamed(context, ExistingMemberRoute.verifyUsername);
                  final mainState = context.read<ExistingMemberBloc>().state;
                  context.read<SelfieBloc>().add(
                        UploadProfileDocument(mainState.selfieImage, mainState.azureInfo),
                      );
                }),
          ],
        ),
      ),
    );
  }

  kycSuccessDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: CustomDialog(
            svgImage: AppSvg.kycSuccess,
            title: LocaleKeys.submittedSuccessfully.value,
            message: LocaleKeys.kycSuccessfulMessage.value,
            primaryButtonTitle: LocaleKeys.goBackToHome.value,
            onPrimaryButtonPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        );
      },
    );
  }
}
