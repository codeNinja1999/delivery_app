import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/di/injector.dart';
import '../pages/address_info/address_info.dart';
import '../pages/payout_info/payout_info.dart';
import '../pages/personal_info/personal_info.dart';
import '../pages/receiving_country/receiving_country.dart';
import '../widget/fraud_information.dart';
import 'beneficiary_route.dart';

class BeneficiaryRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case BeneficiaryRoute.receivingCountry:
        return PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, animation1, animation2) {
            return BlocProvider(
              create: (_) => sl<ReceivingCountryBloc>(),
              child: const ReceivingCountryPage(),
            );
          },
        );

      case BeneficiaryRoute.payoutInfo:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<PayoutInfoBloc>(),
            child: const PayoutInfoPage(),
          ),
        );

      case BeneficiaryRoute.personalInfo:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<PersonalInfoBloc>(),
            child: const PersonalInfoPage(),
          ),
        );

      case BeneficiaryRoute.addressInfo:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AddressInfoBloc>(),
            child: const AddressInfoPage(),
          ),
        );

      case BeneficiaryRoute.fraudDetail:
        return MaterialPageRoute(builder: (_) => const FraudDetails());

      default:
        return MaterialPageRoute(
          builder: (_) => Container(
            color: Colors.red,
          ),
        );
    }
  }
}
