import 'package:get_it/get_it.dart';
import 'package:network/network.dart';

import '../core/app_core.dart';
import '../../repository/data/account_utility/repository/password_repository_impl.dart';
import '../../repository/data/catalog/repository/catalog_repository_impl.dart';
import '../../repository/data/otp/repository/otp_repository_impl.dart';
import '../../repository/data/user/repository/user_authentication_repository_impl.dart';
import '../../repository/data/user/repository/user_registration_repository_impl.dart';
import '../../repository/data/user_utility/repository/user_utilities_repository_impl.dart';
import '../../repository/domain/account_utility/repository/password_repository.dart';
import '../../repository/domain/catalog/repository/catalog_repository.dart';
import '../../repository/domain/otp/repository/otp_repository.dart';
import '../../repository/domain/user/repository/user_authentication_repository.dart';
import '../../repository/domain/user/repository/user_registration_repository.dart';
import '../../repository/domain/user/repository/user_utility_repository.dart';
import '../presentation/admin/add_location/bloc/add_location_bloc.dart';
import '../presentation/admin/add_service_price/bloc/add_service_price_bloc.dart';
import '../presentation/admin/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import '../presentation/admin/admin_profile/bloc/profile_bloc.dart';
import '../presentation/admin/bloc/admin_bloc.dart';
import '../presentation/admin/operator_details/bloc/operator_details_bloc.dart';
import '../presentation/admin/operator_list/bloc/operator_list_bloc.dart';
import '../presentation/admin/update_operator/bloc/update_operator_bloc.dart';
import '../presentation/admin/user_details/bloc/user_details_bloc.dart';
import '../presentation/admin/user_list/bloc/user_list_bloc.dart';
import '../presentation/admin/user_update/bloc/user_update_bloc.dart';
import '../presentation/operator/bloc/operator_bloc.dart';
import '../presentation/operator/operator_dashboard/bloc/operator_dash_board_bloc.dart';
import '../presentation/operator/operator_history/bloc/operator_history_bloc.dart';
import '../presentation/operator/operator_profile/bloc/operator_profile_bloc.dart';
import '../presentation/operator/pickup_order/bloc/pickup_order_bloc.dart';
import '../presentation/user/add_user_location/bloc/add_user_location_bloc.dart';
import '../presentation/user/bloc/user_bloc.dart';
import '../presentation/user/change_password/bloc/change_password_bloc.dart';
import '../presentation/user/checkout/bloc/checkout_bloc.dart';
import '../presentation/user/dashboard/dashboard.dart';
import '../presentation/forgot_password/forgot_password.dart';
import '../presentation/login/login.dart';
import '../presentation/new_member/new_member.dart';
import '../presentation/user/date_selection/bloc/date_selection_bloc.dart';
import '../presentation/user/notification/bloc/notification_list_bloc.dart';
import '../presentation/splash/bloc/splash_bloc.dart';
import '../presentation/user/location/bloc/location_bloc.dart';
import '../presentation/user/order_history/bloc/order_history_bloc.dart';
import '../presentation/user/profile/bloc/profile_bloc.dart';
import '../presentation/user/service_selection/bloc/service_selection_bloc.dart';
import '../presentation/user_agreement/bloc/user_agreement_bloc.dart';

final sl = GetIt.instance;

NetworkClient defaultNetworkClient() => NetworkClientProvider().provideDefaultClient();

NetworkClient userAuthenticationNetworkClient() => NetworkClientProvider().provideUserAuthenticationClient(sl());

NetworkClient defaultPlainNetworkClient() => NetworkClientProvider().provideDefaultPlainClient();

void init() {
  blocsInjection();
  repositoriesInjection();
}

//user authentication
void blocsInjection() {
  sl.registerFactory(() => SplashBloc());

  //new member
  sl.registerFactory(() => NewMemberBloc());
  sl.registerFactory(() => UserAgreementBloc());
  sl.registerFactory(() => UsernameVerifyBloc(otpRepository: sl()));
  sl.registerFactory(() => AccountOtpVerifyBloc(otpRepository: sl()));
  sl.registerFactory(() => RegisterFormBloc(userRegistrationRepository: sl()));

  //login
  sl.registerFactory(() => SetPinBloc());
  sl.registerFactory(() => ForgotPasswordBloc());
  sl.registerFactory(() => OtpVerifyBloc(otpRepository: sl()));
  sl.registerFactory(() => VerifyEmailBloc(otpRepository: sl()));
  sl.registerFactory(() => LoginBloc(userAuthenticationRepository: sl()));
  sl.registerFactory(
    () => ResetPasswordBloc(passwordRepository: PasswordRepositoryImpl(networkClient: sl())),
  );

  //dashboard
  sl.registerFactory(() => DashboardBloc(userUtilitiesRepository: sl(), catalogRepository: sl()));

  //user
  sl.registerFactory(() => UserBloc());
  sl.registerFactory(() => CheckoutBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(() => LocationBloc(catalogRepository: sl()));
  sl.registerFactory(() => OrderHistoryBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(() => DateSelectionBloc());
  sl.registerFactory(() => AddUserLocationBloc());
  sl.registerFactory(() => ServiceSelectionBloc(catalogRepository: sl()));
  sl.registerFactory(() => ProfileBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(() => NotificationListBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(() => ChangePasswordBloc(passwordRepository: sl()));

  //operator
  sl.registerFactory(() => OperatorBloc());
  sl.registerFactory(() => OperatorDashBoardBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(() => OperatorProfileBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(() => PickupOrderBloc());
  sl.registerFactory(() => OperatorHistoryBloc());

  //admin
  sl.registerFactory(() => AdminBloc());
  sl.registerFactory(() => AdminDashboardBloc(userUtilitiesRepository: sl(), catalogRepository: sl()));
  sl.registerFactory(() => AddLocationBloc(catalogRepository: sl()));
  sl.registerFactory(() => AddServicePriceBloc(catalogRepository: sl()));
  sl.registerFactory(() => OperatorListBloc());
  sl.registerFactory(() => OperatorDetailsBloc());
  sl.registerFactory(() => UpdateOperatorBloc());
  sl.registerFactory(() => UserListBloc());
  sl.registerFactory(() => UserDetailsBloc());
  sl.registerFactory(() => UserUpdateBloc());
  sl.registerFactory(() => AdminProfileBloc(userUtilitiesRepository: sl()));
}

///repositories injection
void repositoriesInjection() {
  sl.registerFactory<UserAuthenticationRepository>(
    () => UserAuthenticationRepositoryImpl(networkClient: defaultNetworkClient()),
  );
  sl.registerFactory<PasswordRepository>(
    () => PasswordRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
  );
  sl.registerFactory<UserRegistrationRepository>(
    () => UserRegistrationRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
  );
  sl.registerFactory<OTPRepository>(() => OtpRepositoryImpl(
        networkClient: defaultNetworkClient(),
        userNetworkClient: userAuthenticationNetworkClient(),
      ));
  sl.registerLazySingleton<UserUtilitiesRepository>(
    () => UserUtilitiesRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
  );
  sl.registerFactory<CatalogRepository>(() => CatalogRepositoryImpl(
        networkClient: defaultNetworkClient(),
        userNetworkClient: userAuthenticationNetworkClient(),
      ));
}
