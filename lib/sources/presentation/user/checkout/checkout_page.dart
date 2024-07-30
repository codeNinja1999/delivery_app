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
                    ListTile(
                      tileColor: theme.colorScheme.surfaceContainer,
                      contentPadding: const EdgeInsets.all(AppSize.inset),
                      title: Text(
                        "Phuket, Ban Tawan, 1415 Unit",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "Near ABC Bus Stand",
                        style: theme.textTheme.titleSmall,
                      ),
                      trailing: Icon(Icons.edit),
                      onTap: () => Navigator.pushNamed(context, UserRoute.addLocation),
                    ),
                    const SizedBox(height: AppSize.inset),
                    Container(
                      padding: const EdgeInsets.all(AppSize.viewMargin),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.inset),
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
                          Row(
                            children: [
                              Expanded(child: Text("Service Type")),
                              Expanded(child: Text("Regular Wash")),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Laundry Details")),
                              Expanded(child: Text("12kg")),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Total")),
                              Expanded(child: Text("\$1300")),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.inset),
                    CustomTextField(
                      prefixIcon: Icon(Icons.history),
                      placeholder: "Add Instructions",
                    ),
                    const SizedBox(height: AppSize.inset),
                    Container(
                      padding: const EdgeInsets.all(AppSize.viewMargin),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.inset),
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
                          RadioListTile(title: Text("Credit Type"), value: true, groupValue: true, onChanged: (value) {}),
                          Row(
                            children: [
                              Expanded(child: Text("Credit Type")),
                              Radio(value: true, groupValue: true, onChanged: (value) {}),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("FPX")),
                              Radio(value: true, groupValue: true, onChanged: (value) {}),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Manual Payment slip")),
                              Radio(value: true, groupValue: true, onChanged: (value) {}),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Bank Name")),
                              Expanded(child: Text("ABC Bank")),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Account number")),
                              Expanded(child: Text("1232343543")),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text("Deposit Amount")),
                              Expanded(child: Text("\$1300")),
                            ],
                          ),


                        ],
                      ),
                    ),

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
