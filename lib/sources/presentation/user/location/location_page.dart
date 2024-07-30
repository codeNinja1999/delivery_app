import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/app_bar/app_bar.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/button/custom_button.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final a = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(
        title: "Location Selection",
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
                      leading: Radio(value: a, groupValue: a, onChanged: (value) {}),
                      title: Text(
                        "Phuket, Ban Tawan, 1415 Unit",
                        style: theme.textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "Near ABC Bus Stand",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(height: AppSize.inset),
                    ListTile(
                      tileColor: theme.colorScheme.surfaceContainer,
                      contentPadding: const EdgeInsets.all(AppSize.inset),
                      title: Text(
                        "Add different address",
                        style: theme.textTheme.titleMedium,
                      ),
                      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                      onTap: () => Navigator.pushNamed(context, UserRoute.addLocation),
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
                title: "Save and Continue",
                onPressed: () {
                  Navigator.pushNamed(context, UserRoute.serviceSelection);
                }),
          ],
        ),
      ),
    );
  }
}
