import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/beneficiary_bloc.dart';
import '../route/beneficiary_route.dart';
import '../route/beneficiary_router.dart';

class CreateBeneficiaryPage extends StatefulWidget {
  const CreateBeneficiaryPage({super.key, required this.settings});
  final RouteSettings settings;

  @override
  State<CreateBeneficiaryPage> createState() => _CreateBeneficiaryPageState();
}

class _CreateBeneficiaryPageState extends State<CreateBeneficiaryPage> {
  final _router = BeneficiaryRouter();
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = BeneficiaryRoute.receivingCountry;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        if (currentRoute == BeneficiaryRoute.payoutInfo) {
          Navigator.of(context, rootNavigator: true).pop();
        } else {
          _navigatorKey.currentState!.pop();
        }
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: (context.read<BeneficiaryBloc>().state.fromSendMoney ||
                context.read<BeneficiaryBloc>().state.isEdit)
            ? BeneficiaryRoute.payoutInfo
            : BeneficiaryRoute.receivingCountry,
        onGenerateRoute: (setting) {
          currentRoute = setting.name ?? BeneficiaryRoute.receivingCountry;
          return _router.onGenerateRoute(setting, context);
        },
      ),
    );
  }
}
