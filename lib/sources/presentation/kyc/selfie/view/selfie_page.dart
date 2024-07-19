import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../bloc/kyc_verification_bloc.dart';
import '../../route/kyc_verification_route.dart';
import '../../verification_rule/verification_rule.dart';
import '../bloc/selfie_page_bloc.dart';

class SelfiePage extends StatefulWidget {
  const SelfiePage({super.key});

  @override
  State<SelfiePage> createState() => _SelfiePageState();
}

class _SelfiePageState extends State<SelfiePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<KycVerificationBloc, KycVerificationState>(
          listenWhen: (previous, current) => previous.selfieImage != current.selfieImage,
          listener: (context, state) {
            if (state.selfieImage != null) {
              Navigator.pushNamed(context, KycVerificationRoute.confirmSelfiePage);
            }
          },
        ),
        BlocListener<SelfiePageBloc, SelfiePageState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            final status = state.status;
            (status is InProgress || status is SelfieSubmissionSuccess) ? LoadingView.show() : LoadingView.hide();
            if (status is Success) {
              kycSuccessDialog();
            } else if (status is SubmissionFailure) {
              ErrorResolver.resolve(context, status);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
        body: SingleChildScrollView(
          child: BlocBuilder<SelfiePageBloc, SelfiePageState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.viewMargin,
                      vertical: AppSize.viewSpacing,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          LocaleKeys.takeASelfieWithId.value,
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSize.inset),
                        Text(
                          LocaleKeys.holdSelfieAsInExample.value,
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
                        const SizedBox(height: AppSize.inset),
                        Text(
                          LocaleKeys.maxUploadSize.value,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: AppSize.viewMargin),
                        Text(
                          LocaleKeys.tipsForSelfie.value,
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSize.inset),
                        RulesCard(
                          title: LocaleKeys.tips.value,
                          color: const Color(0xFF3FC555),
                          rule1: LocaleKeys.tipsRule1.value,
                          rule2: LocaleKeys.tipsRule2.value,
                        ),
                        const SizedBox(height: AppSize.viewMargin),
                      ],
                    ),
                  ),
                  Divider(color: theme.disabledColor),
                  BlocBuilder<KycVerificationBloc, KycVerificationState>(
                    buildWhen: (previous, current) => previous.selfieImageName != current.selfieImageName,
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSize.viewMargin,
                          vertical: AppSize.viewSpacing,
                        ),
                        child: Column(
                          children: [
                            CustomButton(
                              title: LocaleKeys.takePhoto.value,
                              onPressed: () {
                                final bloc = context.read<KycVerificationBloc>();
                                bloc.add(GetLocalImage(ScanType.selfie, ScanBy.camera));
                              },
                            ),
                            (state.selfieImageName != null)
                                ? Padding(
                                    padding: const EdgeInsets.only(top: AppSize.inset),
                                    child: CustomButton(
                                      title: LocaleKeys.continueTitle.value,
                                      buttonType: ButtonType.bordered,
                                      onPressed: () {
                                        context.read<SelfiePageBloc>().add(UploadKyc(state.data(state.selfieImageName)));
                                      },
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
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
