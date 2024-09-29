import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/di/injector.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/checkout/bloc/checkout_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/checkout/checkout_page.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/dashboard/dashboard.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/date_selection/bloc/date_selection_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/date_selection/date_selection_page.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/location/location_page.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/order_success/order_success_page.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/route/user_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/service_selection/service_selection_page.dart';

import '../add_user_location/add_user_location_page.dart';
import '../add_user_location/bloc/add_user_location_bloc.dart';
import '../change_password/bloc/change_password_bloc.dart';
import '../change_password/change_password_page.dart';
import '../edit_profile/bloc/edit_profile_bloc.dart';
import '../edit_profile/edit_profile_page.dart';
import '../location/bloc/location_bloc.dart';
import '../notification/bloc/notification_list_bloc.dart';
import '../notification/view/notification_list_pages.dart';
import '../order_history/bloc/order_history_bloc.dart';
import '../order_history/view/order_history_page.dart';
import '../profile/bloc/profile_bloc.dart';
import '../profile/profile_page.dart';
import '../service_selection/bloc/service_selection_bloc.dart';

T? tryCast<T>(dynamic object) => object is T ? object : null;

class UserRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case UserRoute.dashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DashboardBloc>(),
            child: const DashboardPage(),
          ),
        );

      case UserRoute.orderHistory:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OrderHistoryBloc>(),
            child: const OrderHistoryPage(),
          ),
        );

      case UserRoute.profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ProfileBloc>(),
            child: const ProfilePage(),
          ),
        );

      case UserRoute.editProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<EditProfileBloc>(),
            child: const EditProfilePage(),
          ),
        );

      case UserRoute.location:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<LocationBloc>(),
            child: const LocationPage(),
          ),
        );

      case UserRoute.addLocation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AddUserLocationBloc>(),
            child: const AddUserLocationPage(),
          ),
        );

      case UserRoute.serviceSelection:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ServiceSelectionBloc>(),
            child: const ServiceSelectionPage(),
          ),
        );

      case UserRoute.notification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<NotificationListBloc>(),
            child: const NotificationListPage(),
          ),
        );

      case UserRoute.pickupDate:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DateSelectionBloc>(),
            child: const DateSelectionPage(),
          ),
        );

      case UserRoute.checkout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<CheckoutBloc>(),
            child: const CheckoutPage(),
          ),
        );

      case UserRoute.changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ChangePasswordBloc>(),
            child: const ChangePasswordPage(),
          ),
        );

      case UserRoute.orderSuccess:
        return MaterialPageRoute(
          builder: (_) => const OrderSuccessPage(),
        );

      default:
        return MaterialPageRoute(builder: ((_) => Container(color: Colors.red)));
    }
  }

  static void logoutUser(BuildContext context) {
    sl.resetLazySingleton<UserUtilitiesRepository>();
  }
}
