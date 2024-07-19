import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/beneficiary_bloc.dart';
import '../../../route/beneficiary_route.dart';
import '../bloc/receiving_country_bloc.dart';
import 'payment_method_view.dart';
import 'receiving_country_view.dart';

class ReceivingCountryPage extends StatefulWidget {
  const ReceivingCountryPage({super.key});

  @override
  State<ReceivingCountryPage> createState() => _ReceivingCountryPageState();
}

class _ReceivingCountryPageState extends State<ReceivingCountryPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ReceivingCountryBloc>();
    bloc.add(GetReceivingCountry());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceivingCountryBloc, ReceivingCountryState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          context.read<ReceivingCountryBloc>().add(TogglePaymentMethodDialog());
        } else if (status is PaymentModeSelectedSuccess) {
          context.read<BeneficiaryBloc>().add(SavePaymentMode(
                paymentMode: state.payoutType,
                paymentType: state.paymentType,
              ));
          Navigator.pushNamed(context, BeneficiaryRoute.payoutInfo);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: (state.showPaymentMethodDialog) ? const PaymentMethodView() : const ReceivingCountryView(),
        );
      },
    );
  }
}
