import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'user_agreement_event.dart';
part 'user_agreement_state.dart';

class UserAgreementBloc extends Bloc<UserAgreementEvent, UserAgreementState> {
  UserAgreementBloc() : super(UserAgreementState()) {
    on<LoadPdf>(_onLoadPDF);
    on<ProgressChanged>(_onProgressChanged);
  }
  void _onProgressChanged(ProgressChanged event, Emitter<UserAgreementState> emit) {
    emit(state.copyWith(progressValue: event.progressValue));
  }

  Future<Future<File>> _onLoadPDF(
    LoadPdf event,
    Emitter<UserAgreementState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      const url = AppConstants.termAndConditionLink;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      // final completedFile = await completer.future;

      // emit(state.copyWith(pdfPath: completedFile.path, status: InitialStatus()));
    } on Exception catch (e) {
      emit(state.copyWith(status: SubmissionFailure(Exception(e))));
    }

    return completer.future;
  }
}
