import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/button/custom_button.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.orderSuccess,
                      height: MediaQuery.of(context).size.width / 2,
                    ),
                    Text(
                      "Order submitted successfully",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: AppSize.viewSpacing,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: AppSize.viewSpacing),
                    Text(
                      "We will let you know once the operator is on their way",
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppSize.inset),
                  ],
                ),
              ),
            ),
            CustomButton(
                title: "Go to homepage",
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(UserRoute.dashboard, (Route route) => false);
                }),
          ],
        ),
      ),
    );
  }
}
