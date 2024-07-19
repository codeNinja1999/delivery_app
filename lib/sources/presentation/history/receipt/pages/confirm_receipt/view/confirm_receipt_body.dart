import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/receipt_bloc.dart';
import '../bloc/confirm_receipt_bloc.dart';

class ConfirmReceiptBody extends StatefulWidget {
  const ConfirmReceiptBody({super.key});

  @override
  State<ConfirmReceiptBody> createState() => _ConfirmReceiptBodyState();
}

class _ConfirmReceiptBodyState extends State<ConfirmReceiptBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ConfirmReceiptBloc, ConfirmReceiptState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        final mainState = context.read<ReceiptBloc>().state;
        (status is InProgress || status is ReceiptSubmissionSuccess) ? LoadingView.show() : LoadingView.hide();

        if (status is ReceiptSubmissionSuccess) {
          final mainState = context.read<ReceiptBloc>().state;
          context.read<ConfirmReceiptBloc>().add(UploadReceipt(tranNo: mainState.tranNo));
        } else if (status is Success) {
          _showSuccessDialog(context);
        } else if (status is SubmissionFailure) {
          _showFailureDialog(context, mainState);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.viewSpacing,
          horizontal: AppSize.viewMargin,
        ),
        child: CustomScrollView(
          slivers: [
            _buildReceiptHeader(theme),
            _buildReceiptImageAndActions(),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (newContext) {
        return PopScope(
          canPop: false,
          child: CustomDialog(
            title: LocaleKeys.receiptSuccessful.value,
            svgImage: AppSvg.receiptSuccess,
            message: LocaleKeys.receiptSuccessfulMessage.value,
            primaryButtonTitle: LocaleKeys.doneButtonTitle.value,
            onPrimaryButtonPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
          ),
        );
      },
    );
  }

  void _showFailureDialog(BuildContext context, ReceiptState mainState) {
    showDialog(
      context: context,
      builder: (ctx) {
        return CustomDialog(
          title: LocaleKeys.receiptFailed.value,
          imageString: AppSvg.cancel,
          message: LocaleKeys.receiptFailedMessage.value,
          primaryButtonTitle: LocaleKeys.tryAgain.value,
          onPrimaryButtonPressed: () {
            context.read<ConfirmReceiptBloc>().add(UploadReceipt(tranNo: mainState.tranNo));
          },
          secondaryButtonTitle: LocaleKeys.skipIWillDoItLater.value,
        );
      },
    );
  }

  Widget _buildReceiptHeader(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.yourUploadedSlip.value,
            style: theme.textTheme.titleMedium?.copyWith(fontSize: AppSize.iconHeight),
          ),
          const SizedBox(height: AppSize.inset),
          Text(
            LocaleKeys.reviewBeforeUploadingMessage.value,
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
          BlocBuilder<ReceiptBloc, ReceiptState>(
            buildWhen: (previous, current) => previous.receiptImage != current.receiptImage,
            builder: (context, state) {
              final estimatedWidth = MediaQuery.of(context).size.width;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.inset),
                  child: (state.receiptImage != null)
                      ? Image.file(
                          state.receiptImage!,
                          height: estimatedWidth * 0.5,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptImageAndActions() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  title: LocaleKeys.reTake.value,
                  onPressed: () => Navigator.of(context).pop(),
                  buttonType: ButtonType.bordered,
                ),
                const SizedBox(height: AppSize.inset),
                CustomButton(
                    title: LocaleKeys.submit.value,
                    onPressed: () {
                      final mainState = context.read<ReceiptBloc>().state;
                      context.read<ConfirmReceiptBloc>().add(
                            UploadReceipt(receiptImage: mainState.receiptImage, tranNo: mainState.tranNo),
                          );
                      // context.read<ConfirmReceiptBloc>().add(UploadReceipt(
                      //       tranNo: mainState.tranNo,
                      //     ));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
