import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import '../model/model.dart';

part 'transaction_detail_event.dart';
part 'transaction_detail_state.dart';

class TransactionCancelSuccess extends FormStatus {}

class TransactionDetailBloc extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  final TransactionActivityRepository transactionActivityRepository;
  final UserUtilitiesRepository userUtilitiesRepository;

  late String transactionID;

  TransactionDetailBloc({
    required this.transactionActivityRepository,
    required this.userUtilitiesRepository,
  }) : super(TransactionDetailState()) {
    on<Cancel>(_cancelTransaction);
    on<DownloadImage>(_downloadReceipt);
    on<FetchTransactionDetail>(_onFetchTransaction);
    on<UserInfoSubscriptionRequestedDetail>(_onSubscriptionRequested);
    // on<GetInfo>((event, emit) async => await userUtilitiesRepository.getUserInfo());
  }

  void _downloadReceipt(
    DownloadImage event,
    Emitter<TransactionDetailState> emit,
  ) async {
    final customerId = state.receiptDetailViewModel?.customerId;
    final tranId = state.receiptDetailViewModel?.transactionId;
    final recURL =
        Uri.parse("${AppConfig.shared.baseUrl}receipt/transaction-receipt?tranno=$tranId&customer_id=$customerId");

    final response = await http.get(recURL);

    if (response.statusCode == 200) {
      PermissionStatus request;
      var tranFname =
          "THM001-${state.transactionDetailViewModel?.transactionID}-${state.transactionDetailViewModel?.referenceNumber}";

      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          request = await Permission.storage.request();
        } else {
          request = await Permission.storage.request();
        }
      } else {
        request = await Permission.photos.request();
      }

      Directory? dir;
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        dir = await getExternalStorageDirectory();
      }
      final file = File("${dir?.path ?? ""}/$tranFname.pdf");
      if (request.isGranted) {
        final tempFile = await file.writeAsBytes(response.bodyBytes.buffer.asUint8List());
        OpenFile.open(tempFile.path);
        emit(
          state.copyWith(
            status: Success(),
            // pdfDetailModel: PdfDetailModel(
            //   pdfData: response.bodyBytes,
            //   pdfFile: tempFile,
            // ),
          ),
        );
      } else {
        var errorMessage = "Permission denied";
        state.copyWith(status: SubmissionFailure(Exception(errorMessage)));
      }
    } else {
      var errorMessage = "Unable to Download";
      state.copyWith(status: SubmissionFailure(Exception(errorMessage)));
    }
  }

  void _cancelTransaction(
    Cancel event,
    Emitter<TransactionDetailState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final info = CancelTransactionInfo(tranno: transactionID);
    final response = await transactionActivityRepository.cancelTransaction(info);
    emit(
      response.fold((error) => state.copyWith(status: SubmissionFailure(error)), (_) {
        final filter = TransactionListFilter(pageNumber: "1", itemCount: "20", startDate: "", endDate: "", issueType: "02");
        transactionActivityRepository.getTransactionList(filter);
        return state.copyWith(status: TransactionCancelSuccess());
      }),
    );
  }

  void _onFetchTransaction(
    FetchTransactionDetail event,
    Emitter<TransactionDetailState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await transactionActivityRepository.getTransactionDetail(transactionID);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (detail) => state.copyWith(
          status: Success(),
          transactionDetailViewModel: TransactionDetailViewModel.fromTransactionDetail(
            data: detail,
            actualTransactionID: transactionID,
          ),
        ),
      ),
    );
  }

  Future<void> _onSubscriptionRequested(
    UserInfoSubscriptionRequestedDetail event,
    Emitter<TransactionDetailState> emit,
  ) async {
    // emit(state.copyWith(status: InProgress()));
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (info) {
        final viewModel = ReceiptDetailViewModel(customerId: info?.id ?? "", transactionId: transactionID);
        return state.copyWith(receiptDetailViewModel: viewModel);
      },
      onError: (error, __) {
        return state;
      },
    );
  }
}
