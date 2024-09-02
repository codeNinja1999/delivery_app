import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final a = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(
        title: "Checkout",
      ),
      body: Padding(
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
                    GestureDetector(
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
                                    "Phuket, Ban Tawan, 1415 Unit",
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  Text(
                                    "Near ABC Bus Stand",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.edit, color: theme.colorScheme.primary),
                          ],
                        ),
                      ),
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
                            "Order Summary",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: AppSize.inset),
                          const Row(
                            children: [
                              Expanded(child: Text("Service Type : ")),
                              Expanded(
                                child: Text(
                                  "Regular Wash",
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.cornerRadiusMedium),
                          const Row(
                            children: [
                              Expanded(child: Text("Laundry Details : ")),
                              Expanded(
                                  child: Text(
                                "12kg",
                                textAlign: TextAlign.end,
                              )),
                            ],
                          ),
                          const SizedBox(height: AppSize.cornerRadiusMedium),
                          const Row(
                            children: [
                              Expanded(child: Text("Total : ")),
                              Expanded(
                                  child: Text(
                                "\$1300",
                                textAlign: TextAlign.end,
                              )),
                            ],
                          )
                        ],
                      ),
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
                                const Row(
                                  children: [
                                    Expanded(child: Text("Deposit Amount : ")),
                                    Expanded(
                                        child: Text(
                                      "\$1300",
                                      textAlign: TextAlign.end,
                                    )),
                                  ],
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
                  ],
                ),
              ),
            ),
            CustomButton(
                title: "Save and Continue",
                onPressed: () {
                  
                  Navigator.pushNamed(context, UserRoute.orderSuccess);
                }),
          ],
        ),
      ),
    );
  }
}
