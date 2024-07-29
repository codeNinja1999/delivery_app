import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_bar/app_bar.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/button/custom_button.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/textfield/app_textfield.dart';

class ServiceSelectionPage extends StatefulWidget {
  const ServiceSelectionPage({super.key});

  @override
  State<ServiceSelectionPage> createState() => _ServiceSelectionPageState();
}

class _ServiceSelectionPageState extends State<ServiceSelectionPage> {
  final List<Service> services = [
    Service("Regular Wash", "\$100"),
    Service("Regular Wash and Ironing", "\$200"),
    Service("Wash and Press", "\$200"),
    Service("Dry Cleaning", "\$150"),
    Service("Ironing Only", "\$50"),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(
        title: "Service Location",
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
                      "Choose your Service",
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSize.cornerRadiusMedium),
                    Text(
                      "Select  how you wish to do your laundry",
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSize.inset),
                    ListView.separated(
                      itemCount: services.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: AppSize.inset);
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return ListTile(
                          tileColor: theme.colorScheme.surfaceContainer,
                          // contentPadding: const EdgeInsets.all(AppSize.inset),
                          title: Text(
                            service.title,
                            style: theme.textTheme.titleMedium,
                          ),
                          trailing: Text(service.amount),
                          onTap: () {},
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.viewSpacing),
                    Text(
                      "Laundry Details",
                      style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
                    ),
                    const SizedBox(height: AppSize.inset),
                    AppTextfield(
                      title: "Enter total weight",
                      placeHolder: "Example: 12kg",
                    ),
                    const SizedBox(height: AppSize.inset),
                  ],
                ),
              ),
            ),
            CustomButton(
                title: "Continue",
                onPressed: () {
                  showProtectionModel();
                }),
          ],
        ),
      ),
    );
  }

  showProtectionModel() {
    return showModalBottomSheet(
      context: context,
      builder: (newContext) {
        final theme = Theme.of(context);
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Protecting our Operators",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                "our Operators, please confirm that your laundry:",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSize.inset),
              ListTile(
                leading: Checkbox(value: true, onChanged: (value) {}),
                title: Text(
                  "is safe and does not include any biohazard materials",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: AppSize.inset),
              ListTile(
                leading: Checkbox(value: true, onChanged: (value) {}),
                title: Text(
                  "is sanitary and does not contain any feces, vomit, blood",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: AppSize.inset),
              ListTile(
                leading: Checkbox(value: true, onChanged: (value) {}),
                title: Text(
                  "does not contain excessive pet hair",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                "Violators will incur various penalties and even decline in the next order.",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSize.viewSpacing),
              CustomButton(
                  title: "Accept and Continue",
                  onPressed: () {
                    Navigator.pushNamed(context, UserRoute.pickupDate);
                  }),
            ],
          ),
        );
      },
    );
  }
}

class Service {
  final String title;
  final String amount;
  Service(this.title, this.amount);
}
