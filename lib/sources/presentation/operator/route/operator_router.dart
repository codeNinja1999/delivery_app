import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/di/injector.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/presentation/operator/pickup_order/view/pickup_order_page.dart';

import '../operator_dashboard/bloc/operator_dash_board_bloc.dart';
import '../operator_dashboard/view/operator_dashboard_page.dart';
import '../operator_history/bloc/operator_history_bloc.dart';
import '../operator_history/view/operator_history_page.dart';
import '../operator_profile/bloc/operator_profile_bloc.dart';
import '../operator_profile/operator_profile_page.dart';
import '../pickup_order/bloc/pickup_order_bloc.dart';
import 'operator_route.dart';

T? tryCast<T>(dynamic object) => object is T ? object : null;

class OperatorRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case OperatorRoute.dashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OperatorDashBoardBloc>(),
            child: const OperatorDashboardPage(),
          ),
        );

      case OperatorRoute.operatorProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OperatorProfileBloc>(),
            child: const OperatorProfilePage(),
          ),
        );

      case OperatorRoute.history:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OperatorHistoryBloc>(),
            child: const OperatorHistoryPage(),
          ),
        );
      case OperatorRoute.pickupOrder:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<PickupOrderBloc>(),
            child: const PickupOrderPage(),
          ),
        );

      default:
        return MaterialPageRoute(builder: ((_) => Container(color: Colors.green)));
    }
  }

  static void logoutUser(BuildContext context) {
    sl.resetLazySingleton<UserUtilitiesRepository>();

    // Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(AppRoute.splash, (Route<dynamic> route) => false);
  }
}
