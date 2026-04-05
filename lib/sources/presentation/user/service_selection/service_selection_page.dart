import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/service_selection/bloc/service_selection_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../bloc/user_bloc.dart';

class ServiceSelectionPage extends StatefulWidget {
  const ServiceSelectionPage({super.key});

  @override
  State<ServiceSelectionPage> createState() => _ServiceSelectionPageState();
}

class _ServiceSelectionPageState extends State<ServiceSelectionPage> {
  @override
  void initState() {
    super.initState();
    // context.read<ServiceSelectionBloc>().add(FetchServiceType());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPage(
      appBar: const MyAppBar(
        title: "Service Location",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.hInset,
          right: context.hInsetR,
          bottom: AppSize.bottomSafeInset,
        ),
        child: BlocListener<ServiceSelectionBloc, ServiceSelectionState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            final status = state.status;
            (status is InProgress) ? LoadingView.show() : LoadingView.hide();
            if (status is ValidationSuccess) {
              context.read<UserBloc>().add(
                    SaveServiceType(
                      state.selectedServiceType,
                      state.totalWeight,
                      state.totalAmount.toString(),
                    ),
                  );
              showProtectionModel(context);
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
                        "Choose your Service",
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSize.inset * 0.5),
                      Text(
                        "Select how you wish to do your laundry",
                      ),
                      const SizedBox(height: AppSize.inset),
                      BlocBuilder<ServiceSelectionBloc, ServiceSelectionState>(
                        buildWhen: (previous, current) =>
                            previous.serviceTypeList != current.serviceTypeList ||
                            previous.selectedServiceType != current.selectedServiceType,
                        builder: (context, state) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.serviceTypeList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: AppSize.inset);
                            },
                            itemBuilder: (context, index) {
                              final service = state.serviceTypeList[index];
                              return ListTile(
                                minLeadingWidth: AppSize.inset,
                                tileColor: Theme.of(context).scaffoldBackgroundColor,
                                leading: Radio(
                                    value: service.id,
                                    groupValue: state.selectedServiceType?.id,
                                    onChanged: (value) {
                                      null;
                                    }),
                                title: Text(
                                  service.value,
                                  style: theme.textTheme.titleMedium,
                                ),
                                trailing: Text("\$${service.price ?? ""}"),
                                onTap: () {
                                  context.read<ServiceSelectionBloc>().add(ServiceTypeSelected(service));
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: AppSize.viewSpacing),
                      Text(
                        "Laundry Details",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: AppSize.inset),
                      AppTextfield(
                        title: "Enter total weight",
                        placeHolder: "Example: 12kg",
                        textInputType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (weight) {
                          context.read<ServiceSelectionBloc>().add(TotalWeightChanged(weight));
                        },
                      ),
                      const SizedBox(height: AppSize.inset),
                      BlocBuilder<ServiceSelectionBloc, ServiceSelectionState>(
                        buildWhen: (previous, current) =>
                            previous.selectedServiceType != current.selectedServiceType &&
                                previous.totalWeight != current.totalWeight ||
                            previous.totalAmount != current.totalAmount,
                        builder: (context, state) {
                          return Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Total Amount to pay:",
                                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
                              )),
                              Expanded(child: Text(textAlign: TextAlign.right, "\$${state.totalAmount.toString()}"))
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSize.inset),
                    ],
                  ),
                ),
              ),
              CustomButton(
                title: "Continue",
                onPressed: () {
                  showProtectionModel(context);

                  // context.read<ServiceSelectionBloc>().add(ValidateService());
                },
              ),
              // const SizedBox(height: AppSize.viewSpacing),
            ],
          ),
        ),
      ),
    );
  }

  showProtectionModel(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (newContext) {
        final theme = Theme.of(context);
        return BlocProvider.value(
          value: context.read<ServiceSelectionBloc>(),
          child: BlocBuilder<ServiceSelectionBloc, ServiceSelectionState>(
            buildWhen: (previous, current) =>
                previous.noBiohazard != current.noBiohazard ||
                previous.noBlood != current.noBlood ||
                previous.noPetHair != current.noPetHair,
            builder: (context, state) {
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
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                          value: state.noBiohazard,
                          onChanged: (value) {
                            context.read<ServiceSelectionBloc>().add(IsContainBioHazard());
                          }),
                      title: Text(
                        "is safe and does not include any biohazard materials",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: AppSize.inset),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                          value: state.noBlood,
                          onChanged: (value) {
                            context.read<ServiceSelectionBloc>().add(IsContainBlood());
                          }),
                      title: Text(
                        "is sanitary and does not contain any feces, vomit, blood",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: AppSize.inset),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                          value: state.noPetHair,
                          onChanged: (value) {
                            context.read<ServiceSelectionBloc>().add(IsContainPetHair());
                          }),
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
                          context.read<UserBloc>().add(SaveHygieneParameter(state.makeData));
                          Navigator.pushNamed(context, UserRoute.pickupDate);
                        }),
                  ],
                ),
              );
            },
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
