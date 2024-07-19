import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'send_money_success_event.dart';
part 'send_money_success_state.dart';

class SendMoneySuccessBloc extends Bloc<SendMoneySuccessEvent, SendMoneySuccessState> {
  SendMoneySuccessBloc() : super(SendMoneySuccessInitial()) {
    on<CopyTextChanged>((event, emit) {
      emit(state.copyWith(copyText: !state.copyText));
    });
    on<DownloadQRButtonClicked>(
      (event, emit) async {
        emit(DownloadInProgress());
        PermissionStatus request;

        if (Platform.isAndroid) {
          final deviceInfo = DeviceInfoPlugin();
          final androidInfo = await deviceInfo.androidInfo;
          if (androidInfo.version.sdkInt >= 33) {
            request = await Permission.photos.request();
          } else {
            request = await Permission.storage.request();
          }
        } else {
          request = await Permission.photos.request();
        }

        if (request.isGranted) {
          final boundary = event.key.currentContext?.findRenderObject() as RenderRepaintBoundary;

          final image = await boundary.toImage(pixelRatio: 5.0);
          final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));

          if (byteData != null) {
            final pngBytes = byteData.buffer.asUint8List();
            final directory = (await getApplicationDocumentsDirectory()).path;
            final imgFile = File(
              '$directory/${DateTime.now()}qr.png',
            );
            await imgFile.writeAsBytes(pngBytes);
            // await GallerySaver.saveImage(imgFile.path).then((success) async {
            //   emit(DownloadSuccess());
            // });
          } else {
            emit(const ErrorOnDownloading("Unable to download QR Code"));
          }
        } else {
          emit(const ErrorOnDownloading("Permission denied. Please enable permission to save QR"));
        }
      },
    );
  }
}
