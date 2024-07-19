import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'upload_receipt_event.dart';
part 'upload_receipt_state.dart';

class UploadReceiptBloc extends Bloc<UploadReceiptEvent, UploadReceiptState> {
  final UserVerificationRepository userVerificationRepository;
  UploadReceiptBloc({required this.userVerificationRepository}) : super(UploadReceiptState()) {
    on<UploadReceiptEvent>((event, emit) {});
  }
}
