import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

// ignore: must_be_immutable
class QrScanPage extends StatefulWidget {
  QrScanPage({super.key, this.promptPayQR});
  String? promptPayQR;

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    // var qrCodeData = widget.promptPayQR ?? "";
    return Scaffold(
        appBar: MyAppBar(
          title: LocaleKeys.scanQr.value,
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Container(),
          // QrImageView(
          //   data: qrCodeData,
          //   version: QrVersions.auto,
          //   size: 300,
          //   gapless: false,
          //   embeddedImageStyle: const QrEmbeddedImageStyle(
          //     size: Size(80, 80),
          //   ),
          // ),
        ));
  }
}
