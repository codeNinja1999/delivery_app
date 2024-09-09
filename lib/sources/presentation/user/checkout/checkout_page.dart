import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/checkout/bloc/checkout_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../bloc/user_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(
        title: "Checkout",
      ),
      body: BlocListener<CheckoutBloc, CheckoutState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            Navigator.pushNamed(context, UserRoute.orderSuccess);
          } else if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSize.viewMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Choose your Location",
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSize.cornerRadiusMedium),
                      Text(
                        "Where do you like your laundry picked up?",
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSize.inset),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(context, UserRoute.addLocation),
                            child: Container(
                              padding: const EdgeInsets.all(AppSize.inset),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "${state.location?.value ?? ""}, ${state.location?.postalCode ?? ""}",
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        Text(
                                          state.location?.neighborhood ?? "",
                                          style: theme.textTheme.titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.edit, color: theme.colorScheme.primary),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSize.inset),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(AppSize.viewMargin),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                              color: Theme.of(context).colorScheme.surfaceContainer,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Order Summary",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: AppSize.inset),
                                Row(
                                  children: [
                                    const Expanded(child: Text("Service Type : ")),
                                    Expanded(
                                      child: Text(
                                        state.service?.value ?? "",
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSize.cornerRadiusMedium),
                                Row(
                                  children: [
                                    const Expanded(child: Text("Laundry Details : ")),
                                    Expanded(
                                        child: Text(
                                      "${state.totalWeight ?? 0}kg",
                                      textAlign: TextAlign.end,
                                    )),
                                  ],
                                ),
                                const SizedBox(height: AppSize.cornerRadiusMedium),
                                Row(
                                  children: [
                                    const Expanded(child: Text("Total : ")),
                                    Expanded(
                                        child: Text(
                                      "\$${state.totalAmount ?? 0}",
                                      textAlign: TextAlign.end,
                                    )),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSize.inset),
                      const CustomTextField(
                        prefixIcon: Icon(Icons.label),
                        placeholder: "Add Instructions",
                      ),
                      const SizedBox(height: AppSize.inset),
                      Container(
                        padding: const EdgeInsets.all(AppSize.viewMargin),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Payment",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Credit Card",
                                style: theme.textTheme.bodyMedium,
                              ),
                              leading: Icon(Icons.credit_card, color: theme.colorScheme.primary),
                              contentPadding: EdgeInsets.zero,
                              trailing: Radio(value: true, groupValue: true, onChanged: (value) {}),
                            ),
                            ListTile(
                              title: Text(
                                "FPX",
                                style: theme.textTheme.bodyMedium,
                              ),
                              leading: Icon(Icons.wallet, color: theme.colorScheme.primary),
                              contentPadding: EdgeInsets.zero,
                              trailing: Radio(value: false, groupValue: true, onChanged: (value) {}),
                            ),
                            ListTile(
                              title: Text(
                                "Manual Payment Slip",
                                style: theme.textTheme.bodyMedium,
                              ),
                              leading: Icon(Icons.wallet, color: theme.colorScheme.primary),
                              contentPadding: EdgeInsets.zero,
                              trailing: Radio(value: false, groupValue: true, onChanged: (value) {}),
                            ),
                            Container(
                              padding: const EdgeInsets.all(AppSize.inset),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "For Manual Payment Slip Option",
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.inset),
                                  const Row(
                                    children: [
                                      Expanded(child: Text("Bank Name : ")),
                                      Expanded(
                                          child: Text(
                                        "ABC Bank",
                                        textAlign: TextAlign.end,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: AppSize.cornerRadiusMedium),
                                  const Row(
                                    children: [
                                      Expanded(child: Text("Account number : ")),
                                      Expanded(
                                          child: Text(
                                        "1232343543",
                                        textAlign: TextAlign.end,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: AppSize.cornerRadiusMedium),
                                  BlocBuilder<UserBloc, UserState>(
                                    builder: (context, state) {
                                      return  Row(
                                        children: [
                                         const  Expanded(child: Text("Deposit Amount : ")),
                                          Expanded(
                                              child: Text(
                                            "\$${state.totalAmount ?? "0"}",
                                            textAlign: TextAlign.end,
                                          )),
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(height: AppSize.inset),
                                  Text(
                                    "Note: Deposit the amount to the above bank detail and submit the receipt image to complete the order process",
                                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSize.inset),
                      BlocBuilder<CheckoutBloc, CheckoutState>(
                        buildWhen: (previous, current) => previous.receiptImage != current.receiptImage,
                        builder: (context, state) {
                          final estimatedWidth = MediaQuery.of(context).size.height / 4;
                          return GestureDetector(
                            onTap: () => context.read<CheckoutBloc>().add(GetLocalImage(ScanBy.camera)),
                            child: SizedBox(
                              height: estimatedWidth,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(AppSize.inset),
                                padding: const EdgeInsets.all(AppSize.cornerRadiusMedium),
                                child: (state.receiptImage != null)
                                    ? Image.file(
                                        state.receiptImage!,
                                        height: estimatedWidth,
                                        filterQuality: FilterQuality.medium,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(child: Icon(Icons.camera)),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSize.viewSpacing),
                    ],
                  ),
                ),
              ),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return CustomButton(
                      title: "Continue",
                      onPressed: () {
                        final mainState = context.read<UserBloc>().state;
                        context
                            .read<CheckoutBloc>()
                            .add(CreateOrder(mainState.makeData(state.additionalInformation, state.receiptImage)));
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
