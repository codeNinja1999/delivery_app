import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../widgets/widgets.dart';
import 'bloc/add_location_bloc.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final _formKey = GlobalKey<FormState>();
  final countryEditingController = TextEditingController();
  final cityEditingController = TextEditingController();
  final neighborhoodEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AddLocationBloc>().add(GetLocation());
  }

  @override
  void dispose() {
    super.dispose();
    countryEditingController.dispose();
    cityEditingController.dispose();
    neighborhoodEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppPage.scroll(
      appBar: const MyAppBar(
        title: "Add/Edit Location",
      ),
      body: BlocListener<AddLocationBloc, AddLocationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            countryEditingController.text = state.country;
            cityEditingController.text = state.city;
            neighborhoodEditingController.text = state.neighborhood;
          }
          if (status is SubmissionSuccess) {
            Navigator.of(context).pop();
          }
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CountryInput(countryController: countryEditingController),
                const SizedBox(height: AppSize.viewSpacing),
                CityInput(cityController: cityEditingController),
                const SizedBox(height: AppSize.viewSpacing),
                NeighborhoodInput(neighborhoodController: neighborhoodEditingController),
                const SizedBox(height: AppSize.spacedViewSpacing),
                CustomButton(
                    title: "Save Location",
                    onPressed: () {
                      Navigator.of(context).pop();

                      // if (_formKey.currentState!.validate()) {
                      //   context.read<AddLocationBloc>().add(SubmitLocation());
                      // }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CityInput extends StatelessWidget {
  const CityInput({super.key, required this.cityController});
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLocationBloc, AddLocationState>(
      buildWhen: (previous, current) => previous.city != current.city,
      builder: (context, state) {
        return AppTextfield(
          title: "City Name",
          controller: cityController,
          validator: (_) => state.cityValidation,
          onChanged: (city) {
            context.read<AddLocationBloc>().add(CityChanged(city));
          },
        );
      },
    );
  }
}

class CountryInput extends StatelessWidget {
  const CountryInput({super.key, required this.countryController});
  final TextEditingController countryController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLocationBloc, AddLocationState>(
      buildWhen: (previous, current) => previous.country != current.country,
      builder: (context, state) {
        return AppTextfield(
          title: "Country",
          controller: countryController,
          validator: (_) => state.countryValidation,
          onChanged: (country) {
            context.read<AddLocationBloc>().add(CountryChanged(country));
          },
        );
      },
    );
  }
}

class NeighborhoodInput extends StatelessWidget {
  const NeighborhoodInput({super.key, required this.neighborhoodController});
  final TextEditingController neighborhoodController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLocationBloc, AddLocationState>(
      buildWhen: (previous, current) => previous.neighborhood != current.neighborhood,
      builder: (context, state) {
        return AppTextfield(
          title: "Neighborhood",
          controller: neighborhoodController,
          validator: (_) => state.neighborhoodValidation,
          onChanged: (neighborhood) {
            context.read<AddLocationBloc>().add(NeighborhoodChanged(neighborhood));
          },
        );
      },
    );
  }
}
