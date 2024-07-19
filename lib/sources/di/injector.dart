import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:fresh_fold_delivery/repository/data/existing_member/repository/existing_member_repository_impl.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/transaction.dart';

import '../core/app_core.dart';
import '../presentation/app_account_utility/app_account_utility.dart';
import '../presentation/beneficiary/beneficiary.dart';
import '../presentation/check_rate/bloc/check_rate_bloc.dart';
import '../presentation/currency_changer/bloc/currency_changer_bloc.dart';
import '../presentation/dashboard/dashboard.dart';
import '../presentation/device_verification/device_verification.dart';
import '../presentation/registration/existing_member/existing_member.dart';
import '../presentation/forgot_password/forgot_password.dart';
import '../presentation/history/history.dart';
import '../presentation/home_tab/home_tab_bar.dart';
import '../presentation/kyc/kyc_verification.dart';
import '../presentation/kyc/personal_information/personal_information.dart';
import '../presentation/login/login.dart';
import '../presentation/registration/new_member/new_member.dart';
import '../presentation/notification/bloc/notification_list_bloc.dart';
import '../presentation/promotion/bloc/promotion_bloc.dart';
import '../presentation/send_money/send_money.dart';
import '../presentation/splash/bloc/splash_bloc.dart';
import '../presentation/user_agreement/bloc/user_agreement_bloc.dart';

final sl = GetIt.instance;

NetworkClient defaultNetworkClient() => NetworkClientProvider().provideDefaultClient();

NetworkClient appAuthenticationNetworkClient() => NetworkClientProvider().provideAppAuthenticationClient();

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

  //existing member
  sl.registerFactory(() => ExistingMemberBloc());
  sl.registerFactory(() => VerifyNumberBloc(otpRepository: sl()));
  sl.registerFactory(() => VerifyEmailBloc(otpRepository: sl()));
  sl.registerFactory(() => IdValidateBloc(catalogRepository: sl(), existingMemberRepository: sl()));
  sl.registerFactory(() => VerifyOtpBloc(otpRepository: sl()));
  sl.registerFactory(() => NewPasswordBloc(existingMemberRepository: sl()));
  sl.registerFactory(() => SelfieBloc(userUtilitiesRepository: sl(), userVerificationRepository: sl()));

  //Kyc
  sl.registerFactory(
    () => DocumentBackBloc(userVerificationRepository: sl(), userUtilitiesRepository: sl()),
  );
  sl.registerFactory(() => DocumentThicknessBloc(userVerificationRepository: sl()));
  sl.registerFactory(() => VerificationInstructionBloc());
  sl.registerFactory(() => KycVerificationBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(() => CurrentAddressBloc(catalogRepository: sl(), userUtilitiesRepository: sl()));
  sl.registerFactory(() => PromotionBloc(appAuthenticationRepository: sl()));
  sl.registerFactory(() => IdSelectionBloc(catalogRepository: sl(), userUtilitiesRepository: sl()));
  sl.registerFactory(
    () => SelfiePageBloc(userVerificationRepository: sl(), userUtilitiesRepository: sl()),
  );
  sl.registerFactory(() => DocumentFrontBloc(userVerificationRepository: sl()));
  sl.registerFactory(() => DocumentInformationBloc(
        catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
        userUtilitiesRepository: sl(),
        userVerificationRepository: sl(),
      ));
  sl.registerFactory(
    () => PersonalInformationBloc(catalogRepository: sl(), userUtilitiesRepository: sl()),
  );

  //login
  sl.registerFactory(() => SetPinBloc());
  sl.registerFactory(() => ForgotPasswordBloc());
  sl.registerFactory(() => OtpVerifyBloc(otpRepository: sl()));
  sl.registerFactory(() => VerifyUserIdBloc(otpRepository: sl()));
  sl.registerFactory(() => LoginBloc(userAuthenticationRepository: sl()));
  sl.registerFactory(
    () => DeviceVerificationBloc(otpRepository: sl(), userAuthenticationRepository: sl()),
  );
  sl.registerFactory(
    () => ResetPasswordBloc(passwordRepository: PasswordRepositoryImpl(networkClient: appAuthenticationNetworkClient())),
  );

  //dashboard
  sl.registerFactory(() => HomeTabBarBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(
    () => DashboardBloc(
      userUtilitiesRepository: sl(),
      transactionActivityRepository: sl(),
      catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
      exchangeRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => ChangePasswordBloc(
      passwordRepository: PasswordRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
    ),
  );
  sl.registerFactory(
    () => CheckRateBloc(
      transactionActivityRepository: sl(),
      catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
    ),
  );
  sl.registerFactory(
    () => CurrencyChangerBloc(
      catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
    ),
  );

// Notification
  sl.registerFactory(() => NotificationListBloc(userUtilitiesRepository: sl()));

  //beneficiary
  sl.registerFactory(() => BeneficiaryBloc());
  sl.registerFactory(() => PersonalInfoBloc(catalogRepository: sl(), receiverRepository: sl()));
  sl.registerFactory(
    () => ReceivingCountryBloc(
      catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
    ),
  );
  sl.registerFactory(() => PayoutInfoBloc(
        receiverRepository: sl(),
        catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
      ));
  sl.registerFactory(
    () => AddressInfoBloc(
      catalogRepository: sl(),
      receiverRepository: sl(),
      userUtilitiesRepository: sl(),
    ),
  );

  //beneficiary list
  sl.registerFactory(() => FaqBloc());
  sl.registerFactory(() => BeneficiaryDetailBloc(receiverRepository: sl()));
  sl.registerFactory(
    () => BeneficiaryListBloc(receiverRepository: sl(), userUtilitiesRepository: sl()),
  );

  //settings
  sl.registerFactory(() => ChangeLanguageBloc());
  sl.registerFactory(() => AccountBloc(userUtilitiesRepository: sl()));
  sl.registerFactory(
    () => UserPersonalInfoBloc(userUtilitiesRepository: sl(), changeProfilePicRepository: sl()),
  );

  //send money
  sl.registerFactory(() => SendMoneyBloc());
  sl.registerFactory(() => SendMoneySuccessBloc());
  sl.registerFactory(
    () => ConfirmDetailsBloc(transactionActivityRepository: sl(), userUtilitiesRepository: sl()),
  );
  sl.registerFactory(
    () => ReceiverListBloc(
      receiverRepository: sl(),
      catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
      transactionActivityRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => PurposeOfTransferBloc(
      receiverRepository: sl(),
      transactionActivityRepository: sl(),
      catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
    ),
  );
  sl.registerFactory(
    () => ExchangeRateBloc(
      userUtilitiesRepository: sl(),
      transactionActivityRepository: sl(),
      catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient()),
    ),
  );

  //transaction
  sl.registerFactory(() => TransactionListBloc(transactionActivityRepository: sl()));
  sl.registerFactory(
    () => TransactionDetailBloc(transactionActivityRepository: sl(), userUtilitiesRepository: sl()),
  );

  //receipt
  sl.registerFactory(() => ReceiptBloc());
  sl.registerFactory(
    () => DepositBankBloc(catalogRepository: CatalogRepositoryImpl(userNetworkClient: userAuthenticationNetworkClient())),
  );
  sl.registerFactory(() => UploadReceiptBloc(userVerificationRepository: sl()));
  sl.registerFactory(
    () => ConfirmReceiptBloc(transactionActivityRepository: sl(), userVerificationRepository: sl()),
  );

  //topUp
  // sl.registerFactory(() => MoneyTopUpBloc(topUpRepository: sl()));
  // sl.registerFactory(() => UploadSlipBloc());
}

///repositories injection
void repositoriesInjection() {
  sl.registerFactory<ExistingMemberRepository>(
    () => ExistingMemberRepositoryImpl(networkClient: appAuthenticationNetworkClient()),
  );
  sl.registerFactory<UserAuthenticationRepository>(
    () => UserAuthenticationRepositoryImpl(networkClient: appAuthenticationNetworkClient()),
  );
  sl.registerFactory<AppAuthenticationRepository>(
    () => AppAuthenticationRepositoryImpl(networkClient: defaultNetworkClient()),
  );
  sl.registerFactory<UserRegistrationRepository>(
    () => UserRegistrationRepositoryImpl(networkClient: appAuthenticationNetworkClient()),
  );
  sl.registerFactory<ExchangeRateRepository>(
    () => ExchangeRateRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
  );
  sl.registerFactory<OTPRepository>(
    () => SendOtpRepositoryImpl(networkClient: appAuthenticationNetworkClient()),
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
    () => CatalogRepositoryImpl(networkClient: appAuthenticationNetworkClient()),
  );
  sl.registerLazySingleton<ChangeProfilePicRepository>(
    () => ChangeProfilePicRepositoryImpl(networkClient: userAuthenticationNetworkClient()),
  );
  sl.registerFactory<UserVerificationRepository>(
    () => UserVerificationRepositoryImpl(
      networkClient: userAuthenticationNetworkClient(),
      appAuthenticationNetworkClient: appAuthenticationNetworkClient(),
    ),
  );
}
