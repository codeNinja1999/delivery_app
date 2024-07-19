import 'dart:io';

import 'package:fresh_fold_delivery/repository/domain/user/entities/entities.dart';

class DocumentUpload {
  final AzureInfo? azureInfo;
  final File? documentImage;
  final String? docType;

  DocumentUpload({
    this.azureInfo,
    this.docType,
    this.documentImage,
  });
}
