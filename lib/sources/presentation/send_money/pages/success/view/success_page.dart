import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_core.dart';
import '../../../../../resources/resources.dart';
import '../../../../app_account_utility/route/route.dart';
import '../../../../widgets/widgets.dart';
import '../../../send_money.dart';

class SendMoneySuccessPage extends StatefulWidget {
  const SendMoneySuccessPage({super.key});

  @override
  State<SendMoneySuccessPage> createState() => _SendMoneySuccessPageState();
}

class _SendMoneySuccessPageState extends State<SendMoneySuccessPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: AnnotatedRegion(
          value: overlay,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSize.viewMargin),
            child: BlocBuilder<SendMoneyBloc, SendMoneyState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.transactionSuccess,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    const SizedBox(height: AppSize.inset),
                    Text(
                      LocaleKeys.transactionSuccess.value,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSize.inset),
                    Text(
                      LocaleKeys.transactionSuccessMessage.value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: AppSize.inset),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.inset),
                        color: theme.colorScheme.primary.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(AppSize.inset),
                      child: Column(
                        children: [
                          ListModel(
                            data: LocaleKeys.transactionId.value,
                            value: state.confirmTransactionResult?.referenceID ?? "",
                            copyText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSize.cornerRadiusMedium),
                            child: Divider(color: theme.disabledColor),
                          ),
                          ListModel(
                            data: LocaleKeys.recipient.value,
                            value: state.detailedReceiver?.personalInfo?.fullName ?? "",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSize.cornerRadiusMedium),
                            child: Divider(color: theme.disabledColor),
                          ),
                          ListModel(
                            data: LocaleKeys.receivingAmount.value,
                            value:
                                "${state.confirmTransactionResult?.payoutAmount ?? ""} ${state.confirmTransactionResult?.payoutCurrency ?? ""}",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSize.cornerRadiusMedium),
                            child: Divider(color: theme.disabledColor),
                          ),
                          ListModel(
                            data: LocaleKeys.transferAmount.value,
                            value:
                                "${state.confirmTransactionResult?.collectAmount ?? ""} ${state.confirmTransactionResult?.collectCurrency ?? ""}",
                          ),
                        ],
                      ),
                    ),
                    // ListItemView(listItem: list),
                    const SizedBox(height: AppSize.inset),
                    CustomInformationBox(
                      title: LocaleKeys.troubleWithPayment.value,
                      titleTextStyle: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      subTitle: LocaleKeys.letUsKnowHelpCenter.value,
                      leading: const Icon(Icons.support_agent, size: AppSize.inset * 2),
                      trailing: Icon(Icons.arrow_forward_ios, color: theme.colorScheme.primary),
                      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
                        AppAccountUtilityRoute.customerCare,
                      ),
                    ),
                    const SizedBox(height: AppSize.spacedViewSpacing),

                    TextButton(
                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                      child: Text(
                        LocaleKeys.returnBackToHome.value,
                        style: theme.textTheme.bodyLarge?.copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
