import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/send_money_bloc.dart';
import '../bloc/receiver_list_bloc.dart';
import 'receiver_list_view.dart';

class ReceiverListBody extends StatefulWidget {
  final Function(void) onCreateBeneficiary;
  const ReceiverListBody({super.key, required this.onCreateBeneficiary});

  @override
  State<ReceiverListBody> createState() => _ReceiverListBodyState();
}

class _ReceiverListBodyState extends State<ReceiverListBody> {
  @override
  void initState() {
    super.initState();
    final mainState = context.read<SendMoneyBloc>().state;
    final bloc = context.read<ReceiverListBloc>();
    bloc.add(
      GetPaymentMode(
        mainState.calculateTransactionResult?.receiverResult?.payoutInfo?.mode,
        mainState.calculateTransactionResult?.receiverResult?.payoutInfo?.receivingCountry,
      ),
    );
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceiverListBloc, ReceiverListState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.searchText != current.searchText,
      listener: (context, state) {
        final status = state.status;
        if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
        if (state.searchText != "") {
          searchController.text = state.searchText;
        }
      },
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const ProgressIndicatorView(currentStep: 2)];
        },
        body: Padding(
          padding: const EdgeInsets.all(AppSize.inset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReceiverListView(searchController: searchController),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: AppSize.inset),
                child: CustomButton(
                  onPressed: () {
                    widget.onCreateBeneficiary(Void);
                  },
                  title: LocaleKeys.addNew.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
