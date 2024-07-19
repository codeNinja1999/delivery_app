import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../bloc/kyc_verification_bloc.dart';
import '../bloc/selfie_page_bloc.dart';

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
      appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
      body: BlocListener<SelfiePageBloc, SelfiePageState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress || status is SelfieSubmissionSuccess) ? LoadingView.show() : LoadingView.hide();
          if (status is SelfieSubmissionSuccess) {
            final mainState = context.read<KycVerificationBloc>().state;
            context.read<KycVerificationBloc>().add(SaveSelfieDocument(state.selfieImageName ?? ""));
            context.read<SelfiePageBloc>().add(UploadKyc(mainState.data(state.selfieImageName)));
          } else if (status is Success) {
            kycSuccessDialog();
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
                    const SizedBox(height: AppSize.inset),
                    BlocBuilder<KycVerificationBloc, KycVerificationState>(
                      buildWhen: (previous, current) => previous.selfieImage != current.selfieImage,
                      builder: (context, state) {
                        final estimatedWidth = MediaQuery.of(context).size.height / 4;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.inset),
                          child: (state.selfieImage != null)
                              ? Image.file(
                                  state.selfieImage!,
                                  height: estimatedWidth,
                                  filterQuality: FilterQuality.medium,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AppImages.selfie,
                                  height: estimatedWidth,
                                  fit: BoxFit.contain,
                                ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.viewSpacing),
                  ],
                ),
              ),
            ),
            DividerButton(
                backTitle: LocaleKeys.reTake.value,
                nextTitle: LocaleKeys.submit.value,
                backButtonAction: () {
                  context.read<KycVerificationBloc>().add(GetLocalImage(ScanType.selfie, ScanBy.camera));
                  Future.delayed(const Duration(seconds: 2), () => Navigator.of(context).pop());
                },
                nextButtonAction: () {
                  final mainState = context.read<KycVerificationBloc>().state;
                  context.read<SelfiePageBloc>().add(
                        UploadSelfieDocument(mainState.azureInfo, mainState.selfieImage),
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
