import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../core/app_core.dart';

part 'selfie_page_event.dart';
part 'selfie_page_state.dart';

class SelfieSubmissionSuccess extends FormStatus {}

class SelfiePageBloc extends Bloc<SelfiePageEvent, SelfiePageState> {
  final UserVerificationRepository userVerificationRepository;
  final UserUtilitiesRepository userUtilitiesRepository;
  SelfiePageBloc({
    required this.userUtilitiesRepository,
    required this.userVerificationRepository,
  }) : super(SelfiePageState()) {
    // on<UploadImages>(_onDocumentUpload);

    on<UploadSelfieDocument>(_onUploadSelfieDocument);
    on<UploadKyc>(_onUploadKyc);
  }
  // void _onDocumentUpload(
  //   UploadImages event,
  //   Emitter<SelfiePageState> emit,
  // ) async {
  //   emit(state.copyWith(status: InProgress()));
  //   final task = await Future.wait([uploadDocumentImages(event, emit)]);
  //   if (task.every((element) => element == true)) {
  //     userUtilitiesRepository.getUserInfo();
  //     emit(state.copyWith(status: Success()));
  //   }
  // }

  // Future<bool> uploadDocumentImages(UploadImages event, Emitter<SelfiePageState> emit) async {
  //   final data = DocumentImageUploadInfo(
  //     primary: DocumentImageInfo(
  //       idType: event.idType,
  //       idFrontImage: event.primaryImage,
  //     ),
  //     secondary: DocumentImageInfo(
  //       idFrontImage: event.secondaryImage,
  //     ),
  //     additional: DocumentImageInfo(
  //       idFrontImage: event.additionalImage,
  //     ),
  //     selfie: event.selfieImage,
  //   );

  //   final response = await userVerificationRepository.uploadDocumentImage(data);
  //   return response.fold((error) {
  //     emit(state.copyWith(status: SubmissionFailure(error)));
  //     return false;
  //   }, (code) {
  //     return true;
  //   });
  // }

  void _onUploadKyc(UploadKyc event, Emitter<SelfiePageState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userVerificationRepository.uploadCustomerKyc(event.uploadUserKycInfo ?? UploadUserKycInfo());
    response.fold((error) {
      emit(state.copyWith(status: SubmissionFailure(error)));
    }, (code) {
      emit(state.copyWith(status: Success()));
    });
  }

  _onUploadSelfieDocument(UploadSelfieDocument event, Emitter<SelfiePageState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userVerificationRepository.uploadDocument(
      DocumentUpload(azureInfo: event.azureInfo, documentImage: event.selfieImage, docType: "selfie"),
    );
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (docName) => emit(state.copyWith(status: SelfieSubmissionSuccess(), selfieImageName: docName)),
    );
  }
}
