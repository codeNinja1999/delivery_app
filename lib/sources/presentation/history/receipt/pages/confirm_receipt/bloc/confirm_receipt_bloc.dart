import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';

part 'confirm_receipt_event.dart';
part 'confirm_receipt_state.dart';

class ReceiptSubmissionSuccess extends FormStatus {}

class ConfirmReceiptBloc extends Bloc<ConfirmReceiptEvent, ConfirmReceiptState> {
  final TransactionActivityRepository transactionActivityRepository;
  final UserVerificationRepository userVerificationRepository;

  ConfirmReceiptBloc({
    required this.transactionActivityRepository,
    required this.userVerificationRepository,
  }) : super(ConfirmReceiptState()) {
    // on<GetAzureCredentialEvent>(_onGetAzureCredentialEvent);
    // on<UploadReceiptImage>(_onUploadReceiptImage);
    on<UploadReceipt>(uploadReceipt);
  }

  void uploadReceipt(
    UploadReceipt event,
    Emitter<ConfirmReceiptState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));

    final azureInfo = await getAzureCredential(event, emit);
    if (azureInfo != null) {
      final receiptImage = await uploadReceiptImage(event, emit, azureInfo);
      if (receiptImage != null) {
        final info = UploadPaymentInfo(
          tranno: event.tranNo,
          receiptImage: receiptImage,
          // depositBank: event.depositBank,
        );
        final uploadReceiptResponse = await transactionActivityRepository.uploadPaymentReceipt(info);
        uploadReceiptResponse.fold(
          (error) => emit(state.copyWith(status: SubmissionFailure(error))),
          (list) {
            final filter = TransactionListFilter(
              pageNumber: "0",
              itemCount: "20",
              startDate: "",
              endDate: "",
              issueType: "02",
            );
            transactionActivityRepository.getTransactionDetail(event.tranNo ?? "");
            transactionActivityRepository.getTransactionList(filter);
            emit(state.copyWith(status: Success()));
          },
        );
      }
    }
  }

  Future<AzureInfo?> getAzureCredential(UploadReceipt event, Emitter<ConfirmReceiptState> emit) async {
    final response = await userVerificationRepository.getAzureInfo("receipt");

    return response.fold((error) {
      emit(state.copyWith(status: SubmissionFailure(error)));
      return null;
    }, (data) {
      final azureInfo = AzureCredentialsDecoder.decryptAzureInfo(
        azureInfo: data,
        appKey: AppConfig.shared.appKey,
      );
      return azureInfo;
    });
  }

  Future<String?> uploadReceiptImage(UploadReceipt event, Emitter<ConfirmReceiptState> emit, AzureInfo azureInfo) async {
    final response = await userVerificationRepository.uploadDocument(
      DocumentUpload(azureInfo: azureInfo, documentImage: event.receiptImage, docType: "receipt"),
    );
    return response.fold((error) {
      emit(state.copyWith(status: SubmissionFailure(error)));
      return null;
    }, (receiptName) {
      return receiptName;
    });
  }
}
