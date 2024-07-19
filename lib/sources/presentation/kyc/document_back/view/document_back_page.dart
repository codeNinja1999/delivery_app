import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../bloc/kyc_verification_bloc.dart';
import '../../route/kyc_verification_route.dart';
import '../../verification_rule/verification_rule.dart';
import '../bloc/document_back_bloc.dart';

class DocumentBackPage extends StatefulWidget {
  const DocumentBackPage({super.key});

  @override
  State<DocumentBackPage> createState() => _DocumentBackPageState();
}

class _DocumentBackPageState extends State<DocumentBackPage> {
  @override
  void initState() {
    super.initState();
    context.read<DocumentBackBloc>().add(UserInfoSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<KycVerificationBloc, KycVerificationState>(
      listenWhen: (previous, current) => previous.secondaryImage != current.secondaryImage,
      listener: (context, state) {
        if (state.secondaryImage != null) {
          Navigator.pushNamed(context, KycVerificationRoute.confirmBackDocument);
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.inset,
                  vertical: AppSize.viewSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<KycVerificationBloc, KycVerificationState>(
                      buildWhen: (previous, current) => previous.documentType != current.documentType,
                      builder: (context, state) {
                        final title =
                            "${LocaleKeys.upload.value} ${state.documentType?.value ?? ""} ${LocaleKeys.back.value}";
                        return Text(
                          title,
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.inset),
                    Text(
                      LocaleKeys.pleaseUploadIdDocument.value,
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: AppSize.inset),
                    BlocBuilder<KycVerificationBloc, KycVerificationState>(
                      buildWhen: (previous, current) => previous.secondaryImageName != current.secondaryImageName,
                      builder: (context, state) {
                        final estimatedWidth = MediaQuery.of(context).size.height / 4;

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.inset),
                          child: (state.secondaryImageName != null)
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
                    const SizedBox(height: AppSize.inset),
                    Text(
                      LocaleKeys.maxUploadSize.value,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                    const VerificationRule(),
                  ],
                ),
              ),
              Divider(color: theme.disabledColor),
              BlocBuilder<KycVerificationBloc, KycVerificationState>(
                buildWhen: (previous, current) => previous.secondaryImageName != current.secondaryImageName,
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
                            bloc.add(GetLocalImage(ScanType.secondary, ScanBy.camera));
                          },
                        ),
                        (state.secondaryImageName != null)
                            ? Padding(
                                padding: const EdgeInsets.only(top: AppSize.inset),
                                child: CustomButton(
                                  title: LocaleKeys.continueTitle.value,
                                  buttonType: ButtonType.bordered,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      (context.read<DocumentBackBloc>().state.countryCode == "JPN")
                                          ? KycVerificationRoute.documentThickness
                                          : KycVerificationRoute.selfiePage,
                                    );
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
          ),
        ),
      ),
    );
  }
}
