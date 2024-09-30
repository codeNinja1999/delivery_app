import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/pickup_order/pickup_order.dart';
import 'package:fresh_fold_delivery/repository/domain/user/repository/user_utility_repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:image_picker/image_picker.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final UserUtilitiesRepository userUtilitiesRepository;

  CheckoutBloc({required this.userUtilitiesRepository}) : super(CheckoutState()) {
    on<PaymentTypeSelected>(_onPaymentTypeSelected);
    on<CreateOrder>(_onCreateOrder);
    on<GetLocalImage>(_onGetLocalImage);
  }

  Future<void> _onCreateOrder(CreateOrder event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userUtilitiesRepository.createOrder(event.pickupOrder);
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (_) => state.copyWith(status: Success()),
    ));
  }

  _onPaymentTypeSelected(PaymentTypeSelected event, Emitter<CheckoutState> emit) {
    emit(state.copyWith(selectedPaymentType: event.selectedPaymentType));
  }

  Future<void> _onGetLocalImage(
    GetLocalImage event,
    Emitter<CheckoutState> emit,
  ) async {
    final ImagePicker imgPicker = ImagePicker();
    XFile? imageFile;

    if (event.scanBy == ScanBy.camera) {
      imageFile = await imgPicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 100,
      );
    } else {
      imageFile = await imgPicker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 100,
      );
    }
    if (imageFile != null) {
      final image = File(imageFile.path);
      emit(state.copyWith(receiptImage: image));
    } else {
      // emit(state.copyWith(st: "Couldn't not load image"));
    }
  }
}
