import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../config/app/app.dart';
import '../../../../core/app_core.dart';
import '../../../../core/helper/azure_key_helper.dart';

part 'document_front_event.dart';
part 'document_front_state.dart';

class FrontSubmissionSuccess extends FormStatus {}

class DocumentFrontBloc extends Bloc<DocumentFrontEvent, DocumentFrontState> {
  final UserVerificationRepository userVerificationRepository;

  DocumentFrontBloc({required this.userVerificationRepository}) : super(DocumentFrontState()) {
    on<GetAzureKeyEvent>(_onGetAzureKeyEvent);
    on<UploadFrontDocument>(_onUploadFrontDocument);
  }

  _onGetAzureKeyEvent(GetAzureKeyEvent event, Emitter<DocumentFrontState> emit) async {
    final response = await userVerificationRepository.getAzureInfo("customer");
    response.fold((error) => state.copyWith(status: SubmissionFailure(error)), (azureInfo) {
      final azureInfoDecoded = AzureCredentialsDecoder.decryptAzureInfo(
        azureInfo: azureInfo,
        appKey: AppConfig.shared.appKey,
      );
      emit(state.copyWith(azureInfo: azureInfoDecoded));
    });
  }

  _onUploadFrontDocument(UploadFrontDocument event, Emitter<DocumentFrontState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userVerificationRepository.uploadDocument(
      DocumentUpload(
        azureInfo: event.azureInfo,
        documentImage: event.primaryFrontImage,
        docType: "front",
      ),
    );
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (docName) => emit(
        state.copyWith(status: FrontSubmissionSuccess(), primaryFrontImageName: docName),
      ),
    );
  }
}
