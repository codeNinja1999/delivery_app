import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';
import '../bloc/user_bloc.dart';
import '../route/user_route.dart';
import 'bloc/checkout_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPage(
      appBar: const MyAppBar(
        title: "Checkout",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.hInset,
          right: context.hInsetR,
          bottom: AppSize.bottomSafeInset,
        ),
        child: BlocListener<CheckoutBloc, CheckoutState>(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.inset),
                      Text(
                        "Choose your Location",
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSize.inset * 0.5),
                      Text(
                        "Where do you like your laundry picked up?",
                      ),
                      const SizedBox(height: AppSize.inset),
                      BlocBuilder<UserBloc, UserState>(
                        buildWhen: (previous, current) => previous.location != current.location,
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(context, UserRoute.addLocation),
                            child: Container(
                              padding: const EdgeInsets.all(AppSize.inset),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                                border: Border.all(color: Theme.of(context).colorScheme.outline),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "${state.location?.city ?? "Naxal, Kathmandu"} ${state.location?.postalCode ?? "34200"}",
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        Text(
                                          state.location?.neighborhood ?? "Bagbazar",
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
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                              border: Border.all(color: Theme.of(context).colorScheme.outline),
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
                      BlocBuilder<CheckoutBloc, CheckoutState>(
                        buildWhen: (previous, current) => previous.selectedPaymentType != current.selectedPaymentType,
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(AppSize.viewMargin),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                              border: Border.all(color: Theme.of(context).colorScheme.outline),
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
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: state.paymentList.length,
                                    itemBuilder: (context, index) {
                                      final paymentType = state.paymentList[index];
                                      final title = state.paymentList[index].value;
                                      final icon = state.paymentList[index].icon;
                                      return ListTile(
                                        title: Text(
                                          title,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        leading: Icon(icon, color: theme.colorScheme.primary),
                                        contentPadding: EdgeInsets.zero,
                                        trailing: RadioGroup(
                                          groupValue: state.selectedPaymentType?.id,
                                          onChanged: (_) => context.read<CheckoutBloc>().add(
                                                PaymentTypeSelected(paymentType),
                                              ),
                                          child: Radio(
                                            value: paymentType.id,
                                            activeColor: AppColors.primary,
                                          ),
                                        ),
                                        onTap: () => context.read<CheckoutBloc>().add(
                                              PaymentTypeSelected(paymentType),
                                            ),
                                      );
                                    }),
                                (state.selectedPaymentType?.id == "3")
                                    ? Container(
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
                                                return Row(
                                                  children: [
                                                    const Expanded(child: Text("Deposit Amount : ")),
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
                                            const SizedBox(height: AppSize.inset),
                                            BlocBuilder<CheckoutBloc, CheckoutState>(
                                              buildWhen: (previous, current) =>
                                                  previous.receiptImage != current.receiptImage,
                                              builder: (context, state) {
                                                final estimatedWidth = MediaQuery.of(context).size.height / 4;
                                                return GestureDetector(
                                                  onTap: () => showOptionsDialog(context, onCompletion: (scanBy) {
                                                    context.read<CheckoutBloc>().add(GetLocalImage(scanBy));
                                                  }),
                                                  child: DottedBorder(
                                                    strokeWidth: 1,
                                                    dashPattern: const [3, 3],
                                                    borderType: BorderType.RRect,
                                                    radius: const Radius.circular(AppSize.inset),
                                                    padding: const EdgeInsets.all(AppSize.cornerRadiusSmall),
                                                    child: (state.receiptImage != null)
                                                        ? ClipRRect(
                                                            borderRadius: BorderRadius.circular(AppSize.inset),
                                                            child: Image.file(
                                                              state.receiptImage!,
                                                              // height: estimatedWidth,
                                                              width: MediaQuery.of(context).size.width,
                                                              filterQuality: FilterQuality.medium,
                                                              fit: BoxFit.contain,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: estimatedWidth,
                                                            alignment: Alignment.center,
                                                            child: const Icon(Icons.camera)),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
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
                        Navigator.pushNamed(context, UserRoute.orderSuccess);

                        // final mainState = context.read<UserBloc>().state;
                        // context.read<CheckoutBloc>().add(CreateOrder(
                        //       mainState.makeData(
                        //         state.additionalInformation,
                        //         state.receiptImage,
                        //       ),
                        // ));
                      });
                },
              ),
              const SizedBox(height: AppSize.viewSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
