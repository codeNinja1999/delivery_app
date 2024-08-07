import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/admin_dashboard/admin_dashboard.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/bloc/admin_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/operator/bloc/operator_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/operator/operator_dashboard/bloc/operator_dash_board_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/operator/operator_history/bloc/operator_history_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/date_selection/bloc/date_selection_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fresh_fold_delivery/repository/data/existing_member/repository/existing_member_repository_impl.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/transaction.dart';

import '../core/app_core.dart';
import '../presentation/operator/pickup_order/bloc/pickup_order_bloc.dart';
import '../presentation/user/add_location/bloc/add_location_bloc.dart';
import '../presentation/user/bloc/user_bloc.dart';
import '../presentation/user/checkout/bloc/checkout_bloc.dart';
import '../presentation/user/dashboard/dashboard.dart';
import '../presentation/forgot_password/forgot_password.dart';
import '../presentation/history/history.dart';
import '../presentation/login/login.dart';
import '../presentation/new_member/new_member.dart';
import '../presentation/user/notification/bloc/notification_list_bloc.dart';
import '../presentation/splash/bloc/splash_bloc.dart';
import '../presentation/user/location/bloc/location_bloc.dart';
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
  sl.registerFactory(
    () => SplashBloc(appAuthenticationRepository: sl(), userAuthenticationRepository: sl()),
  );

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
  sl.registerFactory(() => VerifyUserIdBloc(otpRepository: sl()));
  sl.registerFactory(() => LoginBloc(userAuthenticationRepository: sl()));
  sl.registerFactory(
    () => ResetPasswordBloc(passwordRepository: PasswordRepositoryImpl(networkClient: sl())),
  );

  //dashboard
  sl.registerFactory(
    () => DashboardBloc(
      userUtilitiesRepository: sl(),
      transactionActivityRepository: sl(),
      catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
    ),
  );

  //user
  sl.registerFactory(() => UserBloc());
  sl.registerFactory(() => CheckoutBloc());
  sl.registerFactory(() => LocationBloc());
  sl.registerFactory(() => AddLocationBloc());
  sl.registerFactory(() => DateSelectionBloc());
  sl.registerFactory(() => ServiceSelectionBloc());
  sl.registerFactory(() => NotificationListBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(() => OrderHistoryBloc(transactionActivityRepository: sl()));

  //operator
  sl.registerFactory(() => OperatorBloc());
  sl.registerFactory(() => OperatorDashBoardBloc());
  sl.registerFactory(() => PickupOrderBloc());
  sl.registerFactory(() => OperatorHistoryBloc(transactionActivityRepository: sl()));

  //admin
  sl.registerFactory(() => AdminBloc());
  sl.registerFactory(() => AdminDashboardBloc());

  //transaction
  sl.registerFactory(
    () => TransactionDetailBloc(transactionActivityRepository: sl(), userUtilitiesRepository: sl()),
  );
}

///repositories injection
void repositoriesInjection() {
  sl.registerFactory<ExistingMemberRepository>(
    () => ExistingMemberRepositoryImpl(networkClient: sl()),
  );
  sl.registerFactory<UserAuthenticationRepository>(
    () => UserAuthenticationRepositoryImpl(networkClient: sl()),
  );
  sl.registerFactory<UserRegistrationRepository>(
    () => UserRegistrationRepositoryImpl(networkClient: sl()),
  );
  sl.registerFactory<OTPRepository>(
    () => SendOtpRepositoryImpl(networkClient: sl()),
  );
  sl.registerLazySingleton<ReceiverRepository>(
    () => ReceiverRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
  );
  sl.registerLazySingleton<UserUtilitiesRepository>(
    () => UserUtilitiesRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
  );
  sl.registerLazySingleton<TransactionActivityRepository>(
    () => TransactionRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
  );
  sl.registerFactory<CatalogRepository>(
    () => CatalogRepositoryImpl(networkClient: sl()),
  );
  // sl.registerFactory<UserVerificationRepository>(
  //   () => UserVerificationRepositoryImpl(
  //     networkClient: userAuthenticationNetworkClient(),
  //     appAuthenticationNetworkClient: appAuthenticationNetworkClient(),
  //   ),
  // );
}
