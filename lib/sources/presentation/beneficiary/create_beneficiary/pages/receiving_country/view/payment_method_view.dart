import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import '../../../widget/fraud_note.dart';
import '../bloc/receiving_country_bloc.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSize.cornerRadiusMedium * 5,
          horizontal: AppSize.inset,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.inset),
          color: theme.colorScheme.surface,
        ),
        width: MediaQuery.of(context).size.width - AppSize.viewSpacing,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.read<ReceivingCountryBloc>().add(TogglePaymentMethodDialog()),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: AppSize.viewMargin),
                  Text(
                    LocaleKeys.chooseReceivingMethod.value,
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(height: AppSize.inset),
              const FraudNotes(),
              const SizedBox(height: AppSize.inset),
              BlocBuilder<ReceivingCountryBloc, ReceivingCountryState>(
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: state.payoutTypeList?.length ?? 0,
                    // items.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppSize.cornerRadiusMedium),
                    itemBuilder: (context, index) {
                      final mode = state.payoutTypeList?[index];
                      return ReceivingMethod(
                        paymentMode: mode,
                        image: getImage(
                          PaymentType.fromPaymentTypeCode(mode?.paymentType ?? "B"),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getImage(PaymentType? paymentType) {
    switch (paymentType) {
      case PaymentType.bank:
        return AppImages.bankTransfer;

      case PaymentType.wallet:
        return AppImages.mobileWallet;

      case PaymentType.cash:
        return AppImages.cashPickup;

      default:
        return AppImages.bankTransfer;
    }
  }
}

class ReceivingMethod extends StatelessWidget {
  final PaymentMode? paymentMode;
  final String image;
  const ReceivingMethod({super.key, required this.paymentMode, required this.image});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.disabledColor),
      ),
      child: ListTile(
        tileColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSize.cornerRadiusMedium,
          horizontal: AppSize.inset,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(image, height: AppSize.inset * 2),
        ),
        title: Text(
          paymentMode?.id ?? "",
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: AppSize.cornerRadiusSmall),
          child: Text(
            paymentMode?.value ?? "",
            style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: AppSize.inset),
          child: SvgPicture.asset(AppSvg.arrowForward, height: 14),
        ),
        onTap: () {
          context
              .read<ReceivingCountryBloc>()
              .add(PayoutTypeSelected(payoutType: paymentMode ?? const PaymentMode(id: "", value: "")));
        },
      ),
    );
  }
}
