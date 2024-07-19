import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../bloc/kyc_verification_bloc.dart';
import '../../route/kyc_verification_route.dart';
import '../../verification_rule/verification_rule.dart';
import '../bloc/document_front_bloc.dart';

class DocumentFrontPage extends StatefulWidget {
  const DocumentFrontPage({super.key});

  @override
  State<DocumentFrontPage> createState() => _DocumentFrontPageState();
}

class _DocumentFrontPageState extends State<DocumentFrontPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<DocumentFrontBloc>().add(GetAzureKeyEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<KycVerificationBloc, KycVerificationState>(
      listenWhen: (previous, current) => previous.primaryImage != current.primaryImage,
      listener: (context, state) {
        if (state.primaryImage != null) {
          final info = context.read<DocumentFrontBloc>().state.azureInfo;
          context.read<KycVerificationBloc>().add(SaveAzureInfo(info));
          Navigator.pushNamed(context, KycVerificationRoute.confirmFrontDocument);
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
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
                      BlocBuilder<KycVerificationBloc, KycVerificationState>(
                        buildWhen: (previous, current) => previous.documentType != current.documentType,
                        builder: (context, state) {
                          final title =
                              "${LocaleKeys.upload.value} ${state.documentType?.value ?? ""} ${LocaleKeys.front.value}";
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
                        buildWhen: (previous, current) => previous.primaryImageName != current.primaryImageName,
                        builder: (context, state) {
                          final estimatedWidth = MediaQuery.of(context).size.height / 4;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.inset),
                            child: (state.primaryImageName != null)
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
                  buildWhen: (previous, current) => previous.primaryImageName != current.primaryImageName,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.inset,
                        vertical: AppSize.viewSpacing,
                      ),
                      child: Column(
                        children: [
                          CustomButton(
                            title: LocaleKeys.takePhoto.value,
                            onPressed: () {
                              final bloc = context.read<KycVerificationBloc>();
                              bloc.add(GetLocalImage(ScanType.primary, ScanBy.camera));
                            },
                          ),
                          (state.primaryImageName != null)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: AppSize.inset),
                                  child: CustomButton(
                                    title: LocaleKeys.continueTitle.value,
                                    buttonType: ButtonType.bordered,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(KycVerificationRoute.documentBack);
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
      ),
    );
  }
}
