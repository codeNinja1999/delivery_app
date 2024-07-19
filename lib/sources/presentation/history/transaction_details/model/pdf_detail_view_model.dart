import 'dart:io';

import 'package:flutter/services.dart';

class PdfDetailModel {
  final Uint8List? pdfData;
  final File? pdfFile;

  PdfDetailModel({this.pdfData, this.pdfFile});
}
