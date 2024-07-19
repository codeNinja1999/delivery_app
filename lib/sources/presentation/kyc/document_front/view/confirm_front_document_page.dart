import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../bloc/kyc_verification_bloc.dart';
import '../../route/kyc_verification_route.dart';
import '../bloc/document_front_bloc.dart';

class ConfirmFrontDocumentPage extends StatefulWidget {
  const ConfirmFrontDocumentPage({super.key});

  @override
  State<ConfirmFrontDocumentPage> createState() => _ConfirmFrontDocumentPageState();
}

class _ConfirmFrontDocumentPageState extends State<ConfirmFrontDocumentPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
      body: BlocListener<DocumentFrontBloc, DocumentFrontState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is FrontSubmissionSuccess) {
            context.read<KycVerificationBloc>().add(SaveFrontDocument(state.primaryFrontImageName ?? ""));
            Navigator.of(context).pushReplacementNamed(KycVerificationRoute.documentBack);
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
                      LocaleKeys.confirmFrontSide.value,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSize.inset),
                    Text(
                      LocaleKeys.reviewBeforeUploadingMessage.value,
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: AppSize.inset),
                    BlocBuilder<KycVerificationBloc, KycVerificationState>(
                      buildWhen: (previous, current) => previous.primaryImage != current.primaryImage,
                      builder: (context, state) {
                        final estimatedWidth = MediaQuery.of(context).size.height / 4;

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.inset),
                          child: (state.primaryImage != null)
                              ? Image.file(
                                  state.primaryImage!,
                                  height: estimatedWidth,
                                  filterQuality: FilterQuality.medium,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  image(state.documentType?.id, DocumentPosition.front),
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
                  final bloc = context.read<KycVerificationBloc>();
                  bloc.add(GetLocalImage(ScanType.primary, ScanBy.camera));
                  Future.delayed(const Duration(seconds: 2), () => Navigator.of(context).pop());
                },
                nextButtonAction: () {
                  final mainState = context.read<KycVerificationBloc>().state;
                  context.read<DocumentFrontBloc>().add(UploadFrontDocument(mainState.azureInfo, mainState.primaryImage));
                }),
          ],
        ),
      ),
    );
  }
}
