import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';
import 'bloc/add_location_bloc.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  @override
  void initState() {
    super.initState();
    context.read<AddLocationBloc>().add(GetLocation());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const MyAppBar(
        title: "Add/Edit Location",
      ),
      backgroundColor: theme.colorScheme.surface,
      body: BlocListener<AddLocationBloc, AddLocationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<AddLocationBloc, AddLocationState>(
                buildWhen: (previous, current) => previous.country != current.country,
                builder: (context, state) {
                  return AppTextfield(
                    title: "Country",
                    controller: TextEditingController()..text = state.country ?? "",
                  );
                },
              ),
              const SizedBox(height: AppSize.viewSpacing),
              BlocBuilder<AddLocationBloc, AddLocationState>(
                buildWhen: (previous, current) => previous.city != current.city,
                builder: (context, state) {
                  return AppTextfield(
                    title: "City Name",
                    controller: TextEditingController()..text = state.city ?? "",
                  );
                },
              ),
              const SizedBox(height: AppSize.viewSpacing),
              BlocBuilder<AddLocationBloc, AddLocationState>(
                buildWhen: (previous, current) => previous.neighborhood != current.neighborhood,
                builder: (context, state) {
                  return AppTextfield(
                    title: "Neighborhood",
                    controller: TextEditingController()..text = state.neighborhood ?? "",
                  );
                },
              ),
              const SizedBox(height: AppSize.viewSpacing),
              BlocBuilder<AddLocationBloc, AddLocationState>(
                builder: (context, state) {
                  return CustomButton(
                      backgroundColor: AppColors.primary,
                      title: "Save Location",
                      onPressed: () {
                        context.read<AddLocationBloc>().add(SubmitLocation(state.makeData()));
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
