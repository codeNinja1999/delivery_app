import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/di/injector.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/dashboard/dashboard.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/location/location_page.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/service_selection/service_selection_page.dart';

import '../location/bloc/location_bloc.dart';
import '../notification/bloc/notification_list_bloc.dart';
import '../notification/view/notification_list_pages.dart';
import '../order_history/bloc/order_history_bloc.dart';
import '../order_history/view/order_history_page.dart';
import '../service_selection/bloc/service_selection_bloc.dart';

T? tryCast<T>(dynamic object) => object is T ? object : null;

class UserRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case UserRoute.dashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<DashboardBloc>(),
            child: const DashboardPage(),
          ),
        );

      case UserRoute.orderHistory:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: sl<OrderHistoryBloc>(),
            child: const OrderHistoryPage(),
          ),
        );

      case UserRoute.location:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<LocationBloc>(),
            child: const LocationPage(),
          ),
        );

      case UserRoute.serviceSelection:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<ServiceSelectionBloc>(),
            child: const ServiceSelectionPage(),
          ),
        );

            case UserRoute.notification:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: sl<NotificationListBloc>(),
              child: const NotificationListPage(),
            ),
          );

      default:
        return MaterialPageRoute(builder: ((_) => Container(color: Colors.green)));
    }
  }

  static void logoutUser(BuildContext context) {
    sl.resetLazySingleton<ReceiverRepository>();
    sl.resetLazySingleton<UserUtilitiesRepository>();
    sl.resetLazySingleton<TransactionActivityRepository>();

    // Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(AppRoute.splash, (Route<dynamic> route) => false);
  }
}
