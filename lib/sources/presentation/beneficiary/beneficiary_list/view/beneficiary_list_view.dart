import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/beneficiary_list_bloc.dart';
import '../model/beneficiary_list_view_model.dart';
import '../widgets/beneficiary_list_item_view.dart';
import '../widgets/empty_beneficiary_view.dart';
import '../widgets/receiver_list_header_view.dart';

class BeneficiaryListView extends StatefulWidget {
  const BeneficiaryListView({super.key});

  @override
  State<BeneficiaryListView> createState() => _BeneficiaryListState();
}

class _BeneficiaryListState extends State<BeneficiaryListView> {
  @override
  void initState() {
    super.initState();
    context.read<BeneficiaryListBloc>().add(BeneficiaryListSubscriptionRequested());
    context.read<BeneficiaryListBloc>().add(GetBeneficiaryList());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () async => context.read<BeneficiaryListBloc>().add(GetBeneficiaryList()),
      child: BlocConsumer<BeneficiaryListBloc, BeneficiaryListState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        builder: (context, state) {
          if (state.status is InProgress) {
            return Skeleton.fromColors(
              baseColor: theme.highlightColor.withOpacity(0.3),
              highlightColor: theme.highlightColor.withOpacity(0.1),
              enabled: true,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return BeneficiaryListItemView(onSelected: () {});
                },
              ),
            );
          }
          if (state.receiverList.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.receiverList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final menuItem = state.receiverList[index];
                      if (menuItem.itemType == PaymentMenuItemType.heading) {
                        return ReceiverListHeaderView(title: menuItem.title);
                      } else {
                        return BeneficiaryListItemView(
                          data: menuItem,
                          onSelected: () {
                            Navigator.pushNamed(context, AppRoute.beneficiaryDetail, arguments: menuItem.receiver?.id);
                          },
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing, horizontal: AppSize.viewMargin),
                  child: CustomButton(
                    title: LocaleKeys.addNewBeneficiary.value,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoute.createBeneficiary);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const EmptyBeneficiaryView();
          }
        },
      ),
    );
  }
}
