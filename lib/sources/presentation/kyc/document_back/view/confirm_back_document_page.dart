import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../bloc/kyc_verification_bloc.dart';
import '../../route/kyc_verification_route.dart';
import '../bloc/document_back_bloc.dart';

class ConfirmBackDocumentPage extends StatefulWidget {
  const ConfirmBackDocumentPage({super.key});

  @override
  State<ConfirmBackDocumentPage> createState() => _ConfirmBackDocumentPageState();
}

class _ConfirmBackDocumentPageState extends State<ConfirmBackDocumentPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
      body: BlocListener<DocumentBackBloc, DocumentBackState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is BackSubmissionSuccess) {
            context.read<KycVerificationBloc>().add(SaveBackDocument(state.secondaryImageName ?? ""));
            Navigator.of(context).pushReplacementNamed(
              (state.countryCode != "JPN") ? KycVerificationRoute.documentThickness : KycVerificationRoute.selfiePage,
            );
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
                  horizontal: AppSize.inset,
                  vertical: AppSize.viewSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.confirmBackSide.value,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSize.inset),
                    Text(
                      LocaleKeys.reviewBeforeUploadingMessage.value,
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: AppSize.inset),
                    BlocBuilder<KycVerificationBloc, KycVerificationState>(
                      buildWhen: (previous, current) => previous.secondaryImage != current.secondaryImage,
                      builder: (context, state) {
                        final estimatedWidth = MediaQuery.of(context).size.height / 4;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.inset),
                          child: (state.secondaryImage != null)
                              ? Image.file(
                                  state.secondaryImage!,
                                  height: estimatedWidth,
                                  filterQuality: FilterQuality.medium,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  image(state.documentType?.id, DocumentPosition.back),
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
                  context.read<KycVerificationBloc>().add(GetLocalImage(ScanType.secondary, ScanBy.camera));
                  Future.delayed(const Duration(seconds: 2), () => Navigator.of(context).pop());
                },
                nextButtonAction: () {
                  final mainState = context.read<KycVerificationBloc>().state;
                  context.read<DocumentBackBloc>().add(UploadBackDocument(mainState.azureInfo, mainState.secondaryImage));
                }),
          ],
        ),
      ),
    );
  }
}
