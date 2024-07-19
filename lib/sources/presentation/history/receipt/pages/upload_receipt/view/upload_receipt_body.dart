import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import '../../../bloc/receipt_bloc.dart';
import '../../../route/receipt_route.dart';

class UploadReceiptBody extends StatefulWidget {
  const UploadReceiptBody({super.key});

  @override
  State<UploadReceiptBody> createState() => _UploadReceiptBodyState();
}

class _UploadReceiptBodyState extends State<UploadReceiptBody> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ReceiptBloc, ReceiptState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (state.receiptImage != null) {
          Navigator.pushNamed(context, ReceiptRoute.confirmReceipt);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.viewSpacing,
          horizontal: AppSize.inset,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppSvg.receipt,
              height: 100,
            ),
            const SizedBox(height: AppSize.inset),
            Text(LocaleKeys.uploadReceiptTitle.value, style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSize.inset),
            Text(
              LocaleKeys.uploadReceiptMessage.value,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSize.viewMargin),
            TextButton.icon(
              onPressed: () => context.read<ReceiptBloc>().add(GetLocalImage(ScanBy.camera)),
              style: TextButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: AppSize.inset, horizontal: AppSize.viewMargin),
              ),
              icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
              label: Text(
                LocaleKeys.useCamera.value,
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: AppSize.viewMargin),
            Text(
              LocaleKeys.or.value,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSize.viewMargin),
              child: CustomInformationBox(
                onTap: () => context.read<ReceiptBloc>().add(GetLocalImage(ScanBy.library)),
                title: LocaleKeys.uploadReceiptFromGallery.value,
                subTitle: LocaleKeys.imageFormat.value,
                subTitleTextStyle: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
