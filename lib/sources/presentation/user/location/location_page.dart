import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/bloc/user_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'bloc/location_bloc.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
    // context.read<LocationBloc>().add(FetchLocation());
  }

  final a = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPage(
      appBar: const MyAppBar(
        title: "Location Selection",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.hInset,
          right: context.hInsetR,
          bottom: AppSize.bottomSafeInset,
        ),
        child: BlocListener<LocationBloc, LocationState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            final status = state.status;
            (status is InProgress) ? LoadingView.show() : LoadingView.hide();
            if (status is ValidateLocationSuccess) {
              context.read<UserBloc>().add(SaveLocation(state.selectedLocation));
              Navigator.pushNamed(context, UserRoute.serviceSelection);
            }
            if (status is SubmissionFailure) {
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
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSize.inset),
                      BlocBuilder<LocationBloc, LocationState>(
                        buildWhen: (previous, current) =>
                            previous.locationList != current.locationList ||
                            previous.selectedLocation != current.selectedLocation,
                        builder: (context, state) {
                          return ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.locationList.length,
                              separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                              itemBuilder: (context, index) {
                                final location = state.locationList[index];
                                return ListTile(
                                    dense: true,
                                    minLeadingWidth: AppSize.cornerRadiusSmall,
                                    tileColor: Theme.of(context).scaffoldBackgroundColor,
                                    contentPadding: const EdgeInsets.all(AppSize.inset),
                                    leading: Radio(
                                        value: location.id,
                                        groupValue: state.selectedLocation?.id,
                                        onChanged: (value) {
                                          null;
                                        }),
                                    title: Text(
                                      "${location.city ?? ""}, ${location.neighborhood ?? ""}",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    subtitle: Text(
                                      location.value,
                                      style: theme.textTheme.titleSmall,
                                    ),
                                    onTap: () {
                                      context.read<LocationBloc>().add(LocationSelection(location));
                                    });
                              });
                        },
                      ),
                      const SizedBox(height: AppSize.inset),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.pushNamed(context, UserRoute.addLocation);
                          // if (result == true) {
                          //   context.read<LocationBloc>().add(FetchLocation());
                          // }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(AppSize.inset),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(color: Theme.of(context).colorScheme.primary),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // contentPadding: const EdgeInsets.all(AppSize.inset),
                              Text(
                                "Add different address",
                                style: theme.textTheme.titleMedium,
                              ),
                              const Icon(Icons.add),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                title: "Save and Continue",
                onPressed: () {
                  // context.read<LocationBloc>().add(ValidateLocation());
                  Navigator.pushNamed(context, UserRoute.serviceSelection);
                },
              ),
              const SizedBox(height: AppSize.viewMargin),
            ],
          ),
        ),
      ),
    );
  }
}
