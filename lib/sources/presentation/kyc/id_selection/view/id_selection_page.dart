import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../core/app_core.dart';
import '../../../../resources/resources.dart';
import '../../../widgets/widgets.dart';
import '../../kyc_verification.dart';

class IdSelectionPage extends StatefulWidget {
  const IdSelectionPage({super.key});

  @override
  State<IdSelectionPage> createState() => _IdSelectionPageState();
}

class _IdSelectionPageState extends State<IdSelectionPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<IdSelectionBloc>();
    bloc.add(IdDocumentSubscription());
    bloc.add(GetIdCatalog());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
      body: BlocListener<IdSelectionBloc, IdSelectionState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: SingleChildScrollView(
          child: BlocBuilder<IdSelectionBloc, IdSelectionState>(
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
                          LocaleKeys.documentType.value,
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSize.inset),
                        Text(
                          LocaleKeys.pleaseSelectIdType.value,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: AppSize.viewMargin),
                        Text(
                          LocaleKeys.idType.value,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: AppSize.inset),
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 0.0),
                          itemCount: state.documentTypeList?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  tileColor: theme.colorScheme.shadow,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSize.inset,
                                    vertical: AppSize.cornerRadiusMedium,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                                    side: BorderSide(color: theme.disabledColor),
                                  ),
                                  title: Text(state.documentTypeList?[index].value ?? ""),
                                  leading: const Icon(Icons.contact_page),
                                  trailing: Radio<String>(
                                    value: state.documentTypeList?[index].value ?? "",
                                    groupValue: state.documentType?.value,
                                    onChanged: null,
                                    fillColor: WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        if (states.contains(WidgetState.selected)) {
                                          return theme.colorScheme.primary;
                                        }
                                        return AppColors.greyColor;
                                      },
                                    ),
                                  ),
                                  onTap: () {
                                    context.read<IdSelectionBloc>().add(
                                          DocumentTypeChanged(
                                            Catalog(
                                                id: state.documentTypeList?[index].value ?? "",
                                                value: state.documentTypeList?[index].value ?? ""),
                                          ),
                                        );
                                  },
                                ),
                                const SizedBox(height: AppSize.inset),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  DividerButton(
                    backTitle: LocaleKeys.back.value,
                    nextTitle: LocaleKeys.nextButtonTitle.value,
                    backButtonAction: () => Navigator.of(context).pop(),
                    nextButtonAction: () {
                      if (state.documentType?.id != "") {
                        context.read<KycVerificationBloc>().add(SaveDocumentType(documentType: state.documentType));
                        Navigator.of(context).pushNamed(KycVerificationRoute.documentInformation);
                      } else {
                        return SnackbarUtils.showSnackbar(
                          context,
                          message: LocaleKeys.documentTypeErrorMessage.value,
                          icon: Icons.error,
                          type: SnackBarType.error,
                        );
                      }
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
}
