import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/di/injector.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/operator_details/operator_details_page.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/route/admin_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/update_operator/update_operator.dart';
import '../add_location/add_location_page.dart';
import '../add_location/bloc/add_location_bloc.dart';
import '../add_service_price/add_service_price_page.dart';
import '../add_service_price/bloc/add_service_price_bloc.dart';
import '../admin_dashboard/bloc/admin_dashboard_bloc.dart';
import '../admin_dashboard/view/admin_dashboard_page.dart';
import '../admin_profile/admin_profile_page.dart';
import '../admin_profile/bloc/profile_bloc.dart';
import '../operator_details/bloc/operator_details_bloc.dart';
import '../operator_list/bloc/operator_list_bloc.dart';
import '../operator_list/operator_list_page.dart';
import '../update_operator/bloc/update_operator_bloc.dart';
import '../user_details/bloc/user_details_bloc.dart';
import '../user_details/user_details.dart';
import '../user_list/bloc/user_list_bloc.dart';
import '../user_list/user_list_page.dart';
import '../user_update/bloc/user_update_bloc.dart';
import '../user_update/user_update_page.dart';

T? tryCast<T>(dynamic object) => object is T ? object : null;

class AdminRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case AdminRoute.adminDashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AdminDashboardBloc>(),
            child: Theme(data: darkTheme, child: const AdminDashboardPage()),
          ),
        );

      case AdminRoute.addLocation:
        final args = tryCast<Location>(settings.arguments);

        final locationBloc = sl<AddLocationBloc>();
        locationBloc.location = args;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => locationBloc,
            child: const AddLocationPage(),
          ),
        );

      case AdminRoute.addServicePrice:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AddServicePriceBloc>(),
            child: const AddServicePricePage(),
          ),
        );

      case AdminRoute.operatorList:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OperatorListBloc>(),
            child: const OperatorListPage(),
          ),
        );

      case AdminRoute.operatorDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OperatorDetailsBloc>(),
            child: const OperatorDetailsPage(),
          ),
        );

      case AdminRoute.updateOperator:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<UpdateOperatorBloc>(),
            child: const UpdateOperatorPage(),
          ),
        );

      case AdminRoute.userList:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<UserListBloc>(),
            child: const UserListPage(),
          ),
        );

      case AdminRoute.profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AdminProfileBloc>(),
            child: const AdminProfilePage(),
          ),
        );

      case AdminRoute.userUpdate:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<UserUpdateBloc>(),
            child: const UserUpdatePage(),
          ),
        );

      case AdminRoute.userDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<UserDetailsBloc>(),
            child: const UserDetailsPage(),
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
