import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

part 'document_thickness_event.dart';
part 'document_thickness_state.dart';

class ThicknessSubmissionSuccess extends FormStatus {}

class DocumentThicknessBloc extends Bloc<DocumentThicknessEvent, DocumentThicknessState> {
  final UserVerificationRepository userVerificationRepository;
  DocumentThicknessBloc({required this.userVerificationRepository}) : super(DocumentThicknessState()) {
    on<UploadThicknessDocument>(_onUploadThicknessDocument);
  }

  _onUploadThicknessDocument(UploadThicknessDocument event, Emitter<DocumentThicknessState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userVerificationRepository.uploadDocument(
      DocumentUpload(azureInfo: event.azureInfo, documentImage: event.thickness, docType: "thickness"),
    );
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (docName) => emit(state.copyWith(status: ThicknessSubmissionSuccess(), thicknessName: docName)),
    );
  }
}
