part of 'document_back_bloc.dart';

abstract class DocumentBackEvent {}

class UploadBackDocument extends DocumentBackEvent {
  final AzureInfo? azureInfo;
  final File? secondaryImage;

  UploadBackDocument(this.azureInfo, this.secondaryImage);
}

class UserInfoSubscriptionRequested extends DocumentBackEvent {}
