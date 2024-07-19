import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/config/app/app_config.dart';
import 'package:fresh_fold_delivery/sources/core/firebase/firebase_config.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class InitialLaunchSuccess extends FormStatus {}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppAuthenticationRepository appAuthenticationRepository;
  final UserAuthenticationRepository userAuthenticationRepository;

  SplashBloc({
    required this.appAuthenticationRepository,
    required this.userAuthenticationRepository,
  }) : super(SplashState()) {
    on<GenerateKey>(generateKey);
  }

  Future<void> generateKey(GenerateKey event, Emitter<SplashState> emit) async {
    emit(state.copyWith(status: InProgress()));

    String? deviceId;
    String? deviceName;
    String? deviceOs;

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id.split('.').join("");
      deviceName = androidInfo.model;
      deviceOs = "android";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      deviceName = iosInfo.name;
      deviceOs = "ios";
    }
    await FirebaseConfiguration.requestNotificationPermission();
    final fcmToken = await FirebaseConfiguration.getFcmToken();

    final appInfo = AppInfo(
      deviceID: deviceId ?? "",
      deviceName: deviceName ?? "",
      deviceOS: deviceOs ?? "",
      appVersion: AppConfig.shared.version,
      fcmRegistrationID: fcmToken,
    );

    final response = await appAuthenticationRepository.generateKey(appInfo, AppConfig.shared.appKey);
    response.fold((error) {
      FormStatus status;
      if (error is NewUpdateAvailable) {
        status = UpdateAvailable(needForceUpdate: error.needForceUpdate, message: error.message);
      } else if (error is UnderMaintenance) {
        status = AppUnderMaintenance(error.message);
      } else {
        status = SubmissionFailure(error);
      }
      emit(state.copyWith(status: status));
    }, (response) {
      emit(
        state.copyWith(status: (response.initialLaunch ?? false) ? InitialLaunchSuccess() : Success()),
      );
    });
  }
}
