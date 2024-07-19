import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/transaction_detail_bloc.dart';
import 'transaction_detail_view.dart';

class TransactionDetailPage extends StatefulWidget {
  const TransactionDetailPage({super.key});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionDetailBloc>().add(UserInfoSubscriptionRequestedDetail());
    context.read<TransactionDetailBloc>().add(FetchTransactionDetail());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<TransactionDetailBloc, TransactionDetailState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        status is InProgress ? LoadingView.show() : LoadingView.hide();

        if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        } else if (status is TransactionCancelSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext buildContext) {
              return PopScope(
                canPop: false,
                child: CustomDialog(
                  svgImage: AppSvg.cancel,
                  title: LocaleKeys.transactionFailed.value,
                  message: LocaleKeys.transactionFailedMessage.value,
                  primaryButtonTitle: LocaleKeys.doneButtonTitle.value,
                  onPrimaryButtonPressed: () {},
                ),
              );
            },
          );
        }
      },
      builder: (context, state) {
        final tranStatus = state.transactionDetailViewModel?.actualStatus;
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(
            backgroundColor: theme.colorScheme.primary,
            surfaceTintColor: Theme.of(context).colorScheme.shadow,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: theme.colorScheme.surface,
              onPressed: () {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
                Navigator.of(context).pop();
              },
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
            bottom: PreferredSize(
              preferredSize: (tranStatus?.type == TransactionType.pendingPayment)
                  ? const Size.fromHeight(AppSize.inset * 14)
                  : const Size.fromHeight(AppSize.inset * 11),
              child: BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: AppSize.inset * 2,
                        backgroundColor: theme.disabledColor,
                        child: SvgPicture.asset(AppSvg.transactionDetails),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: AppSize.inset),
                        child: Text(
                          textAlign: TextAlign.center,
                          state.transactionDetailViewModel?.receiverName ?? "",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ),
                      (tranStatus != null)
                          ? Padding(
                              padding: const EdgeInsets.only(top: AppSize.cornerRadiusMedium, bottom: AppSize.viewMargin),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Status: ",
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: theme.colorScheme.surface,
                                    ),
                                  ),
                                  TransactionStatusColorMappingView(transactionStatus: tranStatus),
                                ],
                              ),
                            )
                          : Container(),
                      (tranStatus?.type == TransactionType.pendingPayment)
                          ? Padding(
                              padding: const EdgeInsets.only(top: AppSize.cornerRadiusMedium, bottom: AppSize.inset),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    title: LocaleKeys.uploadReceiptTitle.value,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoute.uploadReceipt,
                                        arguments: state.transactionDetailViewModel?.actualTransactionID,
                                      ).then((value) {
                                        final shouldRefresh = value as bool;
                                        if (shouldRefresh) {
                                          context.read<TransactionDetailBloc>().add(FetchTransactionDetail());
                                        }
                                      });
                                    },
                                    buttonType: ButtonType.bordered,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSize.inset,
                                      vertical: 0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            ),
          ),
          body: const TransactionDetailView(),
        );
      },
    );
  }
}
