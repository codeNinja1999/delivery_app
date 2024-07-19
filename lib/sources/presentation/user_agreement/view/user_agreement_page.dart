import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/user_agreement_bloc.dart';

class UserAgreementPage extends StatefulWidget {
  const UserAgreementPage({super.key, this.title});
  final String? title;

  @override
  State<UserAgreementPage> createState() => _UserAgreementPageState();
}

class _UserAgreementPageState extends State<UserAgreementPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();
    WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(theme.colorScheme.shadow)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            context.read<UserAgreementBloc>().add(ProgressChanged(progress));
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            print("Error: $error");
          },
          onHttpError: (error) {
            print("Http Error: $error");
          },
        ),
      );

    return Scaffold(
      backgroundColor: theme.bottomSheetTheme.backgroundColor,
      appBar: MyAppBar(title: widget.title),
      body: Column(
        children: [
          BlocBuilder<UserAgreementBloc, UserAgreementState>(
            buildWhen: (previous, current) => previous.progressValue != current.progressValue,
            builder: (context, state) {
              return state.progressValue < 100
                  ? SizedBox(
                      height: 5,
                      child: LinearProgressIndicator(
                        value: state.progressValue / 100,
                        color: theme.colorScheme.primary,
                      ))
                  : Container();
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.viewMargin),
              child: WebViewWidget(
                controller: controller
                  ..loadRequest(
                    Uri.parse(
                      (widget.title == LocaleKeys.termsCondition.value)
                          ? AppConstants.termAndConditionLink
                          : AppConstants.privacyPolicy,
                    ),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
