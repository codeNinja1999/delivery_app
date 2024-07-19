part of 'selfie_bloc.dart';

abstract class SelfieEvent {}

class GetAzureKeyEvent extends SelfieEvent {}

class UploadProfileDocument extends SelfieEvent {
  final File? profileImage;
  final AzureInfo? azureInfo;
  UploadProfileDocument(this.profileImage, this.azureInfo);
}
