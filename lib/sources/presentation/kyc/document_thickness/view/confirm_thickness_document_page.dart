// ignore: unused_import
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../bloc/kyc_verification_bloc.dart';
import '../../route/kyc_verification_route.dart';
import '../bloc/document_thickness_bloc.dart';

class ConfirmThicknessDocumentPage extends StatefulWidget {
  const ConfirmThicknessDocumentPage({super.key});

  @override
  State<ConfirmThicknessDocumentPage> createState() => _ConfirmThicknessDocumentPageState();
}

class _ConfirmThicknessDocumentPageState extends State<ConfirmThicknessDocumentPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
      body: BlocListener<DocumentThicknessBloc, DocumentThicknessState>(
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();

          if (status is ThicknessSubmissionSuccess) {
            context.read<KycVerificationBloc>().add(SaveThicknessDocument(state.thicknessName ?? ""));
            Navigator.of(context).pushReplacementNamed(KycVerificationRoute.selfiePage);
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
                      LocaleKeys.confirmThicknessSide.value,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSize.inset),
                    Text(
                      LocaleKeys.reviewBeforeUploadingMessage.value,
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: AppSize.inset),
                    BlocBuilder<KycVerificationBloc, KycVerificationState>(
                      buildWhen: (previous, current) => previous.additionalImage != current.additionalImage,
                      builder: (context, state) {
                        final estimatedWidth = MediaQuery.of(context).size.height / 4;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.inset),
                          child: (state.additionalImage != null)
                              ? Image.file(
                                  state.additionalImage!,
                                  height: estimatedWidth,
                                  filterQuality: FilterQuality.medium,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AppImages.thickness,
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
                nextTitle: LocaleKeys.nextButtonTitle.value,
                backButtonAction: () {
                  context.read<KycVerificationBloc>().add(GetLocalImage(ScanType.additional, ScanBy.camera));
                  Future.delayed(const Duration(seconds: 2), () => Navigator.of(context).pop());
                },
                nextButtonAction: () {
                  final mainState = context.read<KycVerificationBloc>().state;
                  context
                      .read<DocumentThicknessBloc>()
                      .add(UploadThicknessDocument(mainState.azureInfo, mainState.additionalImage));
                }),
          ],
        ),
      ),
    );
  }
}
