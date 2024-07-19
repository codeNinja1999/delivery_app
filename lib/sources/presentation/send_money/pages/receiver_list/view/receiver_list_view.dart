import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/send_money_bloc.dart';
import '../../../route/send_money_route.dart';
import '../bloc/receiver_list_bloc.dart';
import 'receiver_list_item_view.dart';

class ReceiverListView extends StatelessWidget {
  const ReceiverListView({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppTextfield(
              title: LocaleKeys.whoAreYouSendingAt.value,
              placeHolder: LocaleKeys.searchNameEmailPhone.value,
              controller: searchController,
              suffixIcon: (searchController.text == "")
                  ? const Icon(Icons.search)
                  : TextButton(
                      onPressed: () {
                        searchController.clear();
                        context.read<ReceiverListBloc>().add(SearchTextChanged(""));
                      },
                      child: const Icon(Icons.close, color: Colors.black)),
              onChanged: (text) {
                context.read<ReceiverListBloc>().add(SearchTextChanged(text));
              },
            ),
            const SizedBox(height: AppSize.inset),
            BlocBuilder<ReceiverListBloc, ReceiverListState>(
              buildWhen: (previous, current) => previous.receiverListViewModel != current.receiverListViewModel,
              builder: (context, state) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.receiverListViewModel.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final menuItem = state.receiverListViewModel[index];
                    if (menuItem.heading != null) {
                      return ReceiverListHeaderView(title: menuItem.heading);
                    } else if (menuItem.subHeading != null) {
                      return ReceiverListSubHeaderView(title: menuItem.subHeading);
                    } else {
                      return ReceiverListItemView(
                        data: menuItem,
                        onSelected: (state.receiverListViewModel[index].isDisabledBeneficiary)
                            ? null
                            : () {
                                context.read<SendMoneyBloc>().add(
                                      SaveSelectedReceiver(
                                        detailedReceiver: menuItem.detailedReceiver,
                                        isReceiverResettable: true,
                                      ),
                                    );
                                Navigator.pushNamed(context, SendMoneyRoute.purposeOfTransfer);
                              },
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReceiverListHeaderView extends StatelessWidget {
  const ReceiverListHeaderView({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.inset),
      child: Text(
        title ?? "",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class ReceiverListSubHeaderView extends StatelessWidget {
  const ReceiverListSubHeaderView({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.inset),
      child: Text(
        title ?? "",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
