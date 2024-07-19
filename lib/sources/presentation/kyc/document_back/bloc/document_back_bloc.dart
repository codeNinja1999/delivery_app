import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/entities.dart';
import 'package:fresh_fold_delivery/repository/domain/user/repository/repository.dart';

import '../../../../core/app_core.dart';

part 'document_back_event.dart';
part 'document_back_state.dart';

class BackSubmissionSuccess extends FormStatus {}

class DocumentBackBloc extends Bloc<DocumentBackEvent, DocumentBackState> {
  final UserVerificationRepository userVerificationRepository;
  final UserUtilitiesRepository userUtilitiesRepository;

  DocumentBackBloc({required this.userVerificationRepository, required this.userUtilitiesRepository})
      : super(DocumentBackState()) {
    on<UploadBackDocument>(_onUploadBackDocument);
    on<UserInfoSubscriptionRequested>(_onUserInfoSubscriptionRequested);
  }

  _onUploadBackDocument(UploadBackDocument event, Emitter<DocumentBackState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userVerificationRepository.uploadDocument(
      DocumentUpload(azureInfo: event.azureInfo, documentImage: event.secondaryImage, docType: "back"),
    );
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (docName) => emit(state.copyWith(status: BackSubmissionSuccess(), secondaryImageName: docName)),
    );
  }

  Future<void> _onUserInfoSubscriptionRequested(
    UserInfoSubscriptionRequested event,
    Emitter<DocumentBackState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (userInfo) => userInfo != null ? state.copyWith(countryCode: userInfo.contactInfo?.country?.id) : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }
}
