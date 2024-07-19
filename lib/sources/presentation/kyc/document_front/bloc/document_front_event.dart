part of 'document_front_bloc.dart';

abstract class DocumentFrontEvent {}

class GetAzureKeyEvent extends DocumentFrontEvent {}

class UploadFrontDocument extends DocumentFrontEvent {
  final AzureInfo? azureInfo;
  final File? primaryFrontImage;
  UploadFrontDocument(this.azureInfo, this.primaryFrontImage);
}

