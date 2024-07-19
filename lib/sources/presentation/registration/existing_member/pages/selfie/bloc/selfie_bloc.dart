import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'selfie_event.dart';
part 'selfie_state.dart';

class UploadProfileImageSuccess extends FormStatus {}

class SelfieBloc extends Bloc<SelfieEvent, SelfieState> {
  final UserVerificationRepository userVerificationRepository;
  final UserUtilitiesRepository userUtilitiesRepository;
  SelfieBloc({
    required this.userUtilitiesRepository,
    required this.userVerificationRepository,
  }) : super(SelfieState()) {
    on<UploadProfileDocument>(_onUploadProfileDocument);
    on<GetAzureKeyEvent>(_onGetAzureKeyEvent);
  }

  _onUploadProfileDocument(UploadProfileDocument event, Emitter<SelfieState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userVerificationRepository.uploadDocument(
      DocumentUpload(azureInfo: event.azureInfo, documentImage: event.profileImage, docType: "profile"),
    );
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (docName) => emit(state.copyWith(profileImageName: docName, status: Success())),
    );
  }

  _onGetAzureKeyEvent(GetAzureKeyEvent event, Emitter<SelfieState> emit) async {
    final response = await userVerificationRepository.getAzureInfo("customer");
    response.fold((error) => state.copyWith(status: SubmissionFailure(error)), (azureInfo) {
      final azureInfoDecoded = AzureCredentialsDecoder.decryptAzureInfo(
        azureInfo: azureInfo,
        appKey: AppConfig.shared.appKey,
      );
      emit(state.copyWith(azureInfo: azureInfoDecoded));
    });
  }
}
