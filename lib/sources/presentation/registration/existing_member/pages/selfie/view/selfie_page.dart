import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/presentation/kyc/verification_rule/verification_rule.dart';
import '../../../bloc/existing_member_bloc.dart';
import '../../../route/existing_member_route.dart';
import '../bloc/selfie_bloc.dart';

class SelfiePage extends StatefulWidget {
  const SelfiePage({super.key});

  @override
  State<SelfiePage> createState() => _SelfiePageState();
}

class _SelfiePageState extends State<SelfiePage> {
  @override
  void initState() {
    super.initState();
    context.read<SelfieBloc>().add(GetAzureKeyEvent());
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ExistingMemberBloc, ExistingMemberState>(
      listenWhen: (previous, current) => previous.selfieImage != current.selfieImage,
      listener: (context, state) {
        if (state.selfieImage != null) {
          final azureKey = context.read<SelfieBloc>().state.azureInfo;
          context.read<ExistingMemberBloc>().add(SaveAzureInfo(azureKey));
          Navigator.pushNamed(context, ExistingMemberRoute.confirmSelfie);
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const MyAppBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                      Text(
                        LocaleKeys.selfieTitle.value,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppSize.inset),
                      Text(
                        LocaleKeys.selfieExample.value,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: AppSize.viewMargin),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.inset),
                        child: Image.asset(
                          AppImages.profile,
                          height: MediaQuery.of(context).size.width * 0.5,
                          fit: BoxFit.contain,
                        ),
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
                        rule1: LocaleKeys.selfieRule1.value,
                        rule2: LocaleKeys.selfieRule2.value,
                        rule3: LocaleKeys.tipsRule2.value,
                      ),
                      const SizedBox(height: AppSize.viewMargin),
                    ],
                  ),
                ),
                Divider(color: theme.disabledColor),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.inset,
                    vertical: AppSize.viewSpacing,
                  ),
                  child: CustomButton(
                    title: LocaleKeys.takePhoto.value,
                    onPressed: () {
                      context.read<ExistingMemberBloc>().add(GetLocalImage(ScanType.selfie, ScanBy.camera));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
