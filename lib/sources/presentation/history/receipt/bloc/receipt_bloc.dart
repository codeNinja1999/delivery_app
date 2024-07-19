import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fresh_fold_delivery/repository/domain/domain.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class LoadReceiptSuccess extends FormStatus {}

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc() : super(ReceiptState()) {
    on<GetLocalImage>(_onGetLocalImage);
    on<SaveAzureInfo>((event, emit) => emit(state.copyWith(azureInfo: event.azureInfo)));
    on<GetTransactionId>((event, emit) => emit(state.copyWith(tranNo: event.transactionId)));
    on<SaveDepositBank>((event, emit) => emit(state.copyWith(depositBank: event.depositBank)));
  }

  Future<void> _onGetLocalImage(
    GetLocalImage event,
    Emitter<ReceiptState> emit,
  ) async {
    final ImagePicker imgPicker = ImagePicker();
    XFile? imageFile;
    imageFile = await imgPicker.pickImage(
      source: (event.scanBy == ScanBy.camera) ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 100,
    );
    if (imageFile != null) {
      final image = File(imageFile.path);
      emit(
        state.copyWith(receiptImage: image, status: LoadReceiptSuccess()),
      );
    } else {
      emit(state.copyWith(status: SubmissionFailure(Exception("Couldn't not load image"))));
    }
  }
}
