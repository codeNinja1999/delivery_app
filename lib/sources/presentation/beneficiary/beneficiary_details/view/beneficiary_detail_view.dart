import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/beneficiary_detail_bloc.dart';
import 'account_details_view.dart';
import 'address_details_view.dart';

class BeneficiaryDetailView extends StatelessWidget {
  const BeneficiaryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: AppSize.viewSpacing, horizontal: AppSize.viewMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BeneficiaryHeaderView(),
          BeneficiaryOptionsView(),
          AccountDetailsView(),
          AddressDetailsView(),
        ],
      ),
    );
  }
}

class BeneficiaryHeaderView extends StatelessWidget {
  const BeneficiaryHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BeneficiaryDetailBloc, BeneficiaryDetailState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BeneficiaryInitialsAvatar(),
            Text(
              textAlign: TextAlign.center,
              state.receiver?.username ?? "",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSize.cornerRadiusMedium),
            const BeneficiaryPayoutMethod(),
          ],
        );
      },
    );
  }
}

class BeneficiaryPayoutMethod extends StatelessWidget {
  const BeneficiaryPayoutMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BeneficiaryDetailBloc, BeneficiaryDetailState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              state.receiver?.payoutMethod ?? "",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: AppSize.inset * 0.25),
            // if (state.receiver?.flagUrl != null && state.receiver?.flagUrl
            BorderImage(
              size: AppSize.viewSpacing,
              imageUrl: state.receiver?.flagUrl ?? AppConstants.defaultFlagUrl,
            )
            // SvgPicture.network(
            //   state.receiver?.flagUrl ?? AppConstants.nepalFlagUrl,
            //   height: AppSize.inset,
            //   width: AppSize.inset,
            // ),
          ],
        );
      },
    );
  }
}

class BeneficiaryInitialsAvatar extends StatelessWidget {
  const BeneficiaryInitialsAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BeneficiaryDetailBloc, BeneficiaryDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSize.inset),
          child: CircleAvatar(
            radius: 41,
            child: CircleAvatar(
              backgroundColor: theme.colorScheme.secondaryContainer,
              radius: AppSize.profileImageHeight / 2,
              child: Text(
                state.receiver?.avatarLabel ?? "",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BeneficiaryOptionsView extends StatelessWidget {
  const BeneficiaryOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BeneficiaryDetailBloc, BeneficiaryDetailState>(
      builder: (context, state) {
        getReceiverDetails(bool refresh) {
          (refresh) ? context.read<BeneficiaryDetailBloc>().add(GetReceiverDetail()) : null;
        }

        return Padding(
          padding: const EdgeInsets.only(top: AppSize.viewMargin, bottom: AppSize.spacedViewSpacing * 0.84),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final shouldRefresh = await Navigator.pushNamed(
                    context,
                    AppRoute.createBeneficiary,
                    arguments: state.detailedReceiver,
                  );
                  getReceiverDetails(shouldRefresh as bool);
                },
                child: Container(
                  height: AppSize.buttonHeight,
                  width: AppSize.buttonHeight,
                  padding: const EdgeInsets.all(AppSize.inset),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.buttonHeight),
                    color: theme.colorScheme.primary,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: AppSize.inset),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoute.sendMoney, arguments: state.detailedReceiver);
                },
                child: Container(
                  height: AppSize.buttonHeight,
                  width: AppSize.buttonHeight,
                  padding: const EdgeInsets.all(AppSize.inset),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.buttonHeight),
                    color: theme.colorScheme.primary,
                  ),
                  child: SvgPicture.asset(AppSvg.sendIcon),
                ),
              ),
              const SizedBox(width: AppSize.inset),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (newContext) {
                      return CustomDialog(
                        svgImage: AppSvg.deleteIcon,
                        title: LocaleKeys.deleteBeneficiary.value,
                        message: LocaleKeys.deleteBeneficiaryMessage.value,
                        primaryButtonTitle: LocaleKeys.yes.value,
                        secondaryButtonTitle: LocaleKeys.no.value,
                        onPrimaryButtonPressed: () {
                          context.read<BeneficiaryDetailBloc>().add(DeleteReceiverDetail());
                        },
                      );
                    },
                  );
                },
                child: Container(
                  height: AppSize.buttonHeight,
                  width: AppSize.buttonHeight,
                  padding: const EdgeInsets.all(AppSize.inset),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.error.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(AppSize.buttonHeight),
                  ),
                  child: SvgPicture.asset(AppSvg.deleteIcon),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ListItemViewDetail extends StatelessWidget {
  final String title;
  final String? value;
  const ListItemViewDetail({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.inset * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: textTheme.titleMedium?.color?.withOpacity(0.7),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: AppSize.inset * 0.25),
          Text(value ?? '', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
