import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'bloc/add_service_price_bloc.dart';

class AddServicePricePage extends StatefulWidget {
  const AddServicePricePage({super.key});

  @override
  State<AddServicePricePage> createState() => _AddServicePricePageState();
}

class _AddServicePricePageState extends State<AddServicePricePage> {
  final _formKey = GlobalKey<FormState>();
  final serviceNameEditingController = TextEditingController();
  final priceEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AddServicePriceBloc>().add(GetServiceType());
  }

  @override
  void dispose() {
    super.dispose();
    serviceNameEditingController.dispose();
    priceEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const MyAppBar(
        title: "Add/Edit Service",
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<AddServicePriceBloc, AddServicePriceState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            serviceNameEditingController.text = state.serviceName;
            priceEditingController.text = state.price;
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
            padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ServiceNameInput(serviceNameController: serviceNameEditingController),
                const SizedBox(height: AppSize.viewSpacing),
                PriceInput(priceController: priceEditingController),
                const SizedBox(height: AppSize.spacedViewSpacing),
                CustomButton(
                    title: "Save Service",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AddServicePriceBloc>().add(SubmitService());
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriceInput extends StatelessWidget {
  const PriceInput({super.key, required this.priceController});
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddServicePriceBloc, AddServicePriceState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        return AppTextfield(
          title: "Price",
          controller: priceController,
          validator: (_) => state.priceValidation,
          onChanged: (price) {
            context.read<AddServicePriceBloc>().add(PriceChanged(price));
          },
        );
      },
    );
  }
}

class ServiceNameInput extends StatelessWidget {
  const ServiceNameInput({super.key, required this.serviceNameController});
  final TextEditingController serviceNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddServicePriceBloc, AddServicePriceState>(
      buildWhen: (previous, current) => previous.serviceName != current.serviceName,
      builder: (context, state) {
        return AppTextfield(
          title: "Service Name",
          controller: serviceNameController,
          validator: (_) => state.serviceNameValidation,
          onChanged: (serviceName) {
            context.read<AddServicePriceBloc>().add(ServiceNameChanged(serviceName));
          },
        );
      },
    );
  }
}
