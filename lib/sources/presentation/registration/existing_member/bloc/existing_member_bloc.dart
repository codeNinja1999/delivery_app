import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

part 'existing_member_event.dart';
part 'existing_member_state.dart';

class ExistingMemberBloc extends Bloc<ExistingMemberEvent, ExistingMemberState> {
  ExistingMemberBloc() : super(const ExistingMemberState()) {
    on<VerificationDetailCollected>(_onVerificationDetailCollected);

    on<SetUserPassword>((event, emit) => emit(state.copyWith(password: event.password)));

    on<SaveProcessID>(
      (event, emit) => emit(state.copyWith(processID: event.processId)),
    );
    on<SaveSelfieImage>(
      (event, emit) => emit(state.copyWith(selfieImageName: event.selfieImageName)),
    );
    on<SaveAzureInfo>(
      (event, emit) => emit(state.copyWith(azureInfo: event.azureInfo)),
    );
    on<SaveExistingMemberResult>(_onSaveExistingMemberResult);

    on<SaveUserPersonalInfo>(
      (event, emit) => emit(state.copyWith(userPersonalInfo: event.userPersonalInfo, email: event.email)),
    );
    on<GetLocalImage>(_onGetLocalImage);
  }

  Future<void> _onGetLocalImage(
    GetLocalImage event,
    Emitter<ExistingMemberState> emit,
  ) async {
    final ImagePicker imgPicker = ImagePicker();
    XFile? imageFile;

    imageFile = await imgPicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100,
    );
    if (imageFile != null) {
      final image = File(imageFile.path);
      final newState = state.copyWith(selfieImage: image);
      emit(newState);
    }
  }

  _onVerificationDetailCollected(
    VerificationDetailCollected event,
    Emitter<ExistingMemberState> emit,
  ) {
    emit(state.copyWith(
      userName: event.userName,
      verificationProcessID: event.processId,
    ));
  }

  _onSaveExistingMemberResult(
    SaveExistingMemberResult event,
    Emitter<ExistingMemberState> emit,
  ) {
    emit(state.copyWith(existingMemberResult: event.existingMemberResult));
  }
}
