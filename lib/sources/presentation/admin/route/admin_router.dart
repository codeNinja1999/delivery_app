import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/di/injector.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/route/admin_route.dart';
import '../admin_dashboard/bloc/admin_dashboard_bloc.dart';
import '../admin_dashboard/view/admin_dashboard_page.dart';

T? tryCast<T>(dynamic object) => object is T ? object : null;

class AdminRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case AdminRoute.adminDashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AdminDashboardBloc>(),
            child: const AdminDashboardPage(),
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
