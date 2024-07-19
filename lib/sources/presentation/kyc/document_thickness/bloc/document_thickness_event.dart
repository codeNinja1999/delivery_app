part of 'document_thickness_bloc.dart';

abstract class DocumentThicknessEvent {}

class UploadThicknessDocument extends DocumentThicknessEvent {
  final AzureInfo? azureInfo;
  final File? thickness;

  UploadThicknessDocument(this.azureInfo, this.thickness);
}
