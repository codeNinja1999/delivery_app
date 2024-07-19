import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../core/app_core.dart';

part 'kyc_verification_event.dart';
part 'kyc_verification_state.dart';

class KycVerificationBloc extends Bloc<KycVerificationEvent, KycVerificationState> {
  final UserUtilitiesRepository userUtilitiesRepository;

  KycVerificationBloc({required this.userUtilitiesRepository}) : super(KycVerificationState()) {
    on<SavePersonalInfo>(
      (event, emit) {
        emit(state.copyWith(
          firstName: event.firstName,
          middleName: event.middleName,
          lastName: event.lastName,
          nationality: event.nationality,
          dateOfBirth: event.dateOfBirth,
          gender: event.gender,
          occupation: event.occupation,
          visaType: event.visaType,
        ));
      },
    );

    on<SaveAddressInfo>(
      (event, emit) {
        emit(state.copyWith(
          state: Catalog(id: event.state ?? "", value: event.state ?? ""),
          city: event.city,
          zipCode: event.zipCode,
          streetAddress: event.streetAddress,
          japaneseStreetAddress: event.japaneseStreetAddress,
          japaneseSenderAddress: event.japaneseSenderAddress,
        ));
      },
    );

    on<SaveDocumentInformation>(
      (event, emit) {
        emit(state.copyWith(
          idNumber: event.idNumber,
          idIssueDate: event.idIssueDate,
          idIssueCountry: event.idIssueCountry,
          idExpiryDate: event.idExpiryDate,
        ));
      },
    );

    on<SaveDocumentType>((event, emit) {
      emit(state.copyWith(documentType: event.documentType));
    });
    on<SaveFrontDocument>((event, emit) {
      emit(state.copyWith(primaryImageName: event.frontDocument));
    });
    on<SaveBackDocument>((event, emit) {
      emit(state.copyWith(secondaryImageName: event.backDocument));
    });
    on<SaveThicknessDocument>((event, emit) {
      emit(state.copyWith(additionalImageName: event.thickness));
    });
    on<SaveSelfieDocument>((event, emit) {
      emit(state.copyWith(selfieImageName: event.selfie));
    });

    on<ClearPrimaryDocument>((event, emit) {
      emit(state.copyWith(isClearPrimaryDoc: true));
    });
    on<ClearSecondaryDocument>((event, emit) {
      emit(state.copyWith(isClearSecondaryDoc: true));
    });
    on<ClearAdditionalDocument>((event, emit) {
      emit(state.copyWith(isClearAdditionalDoc: true));
    });
    on<ClearSelfie>((event, emit) {
      emit(state.copyWith(isClearSelfie: true));
    });
    on<SaveAzureInfo>((event, emit) {
      emit(state.copyWith(azureInfo: event.azureInfo));
    });
    // on<UploadDocument>(_onUploadDocument);

    on<GetLocalImage>(_onGetLocalImage);
  }

  Future<void> _onGetLocalImage(
    GetLocalImage event,
    Emitter<KycVerificationState> emit,
  ) async {
    final ImagePicker imgPicker = ImagePicker();
    XFile? imageFile;

    try {
      if (event.scanBy == ScanBy.camera && event.scanFor == ScanType.selfie) {
        imageFile = await imgPicker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
          // maxHeight: 480,
          // maxWidth: 640,
          imageQuality: 100,
        );
      } else if (event.scanBy == ScanBy.camera) {
        imageFile = await imgPicker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear,
          // maxHeight: 480,
          // maxWidth: 640,
          imageQuality: 100,
        );
      } else {
        imageFile = await imgPicker.pickImage(
          source: ImageSource.gallery,
          preferredCameraDevice: CameraDevice.rear,
          // maxHeight: 480,
          // maxWidth: 640,
          imageQuality: 100,
        );
      }
      if (imageFile != null) {
        final scanFor = event.scanFor;
        final image = File(imageFile.path);

        final newState = state.copyWith(
          primaryImage: scanFor == ScanType.primary ? image : null,
          secondaryImage: scanFor == ScanType.secondary ? image : null,
          additionalImage: scanFor == ScanType.additional ? image : null,
          selfieImage: scanFor == ScanType.selfie ? image : null,
        );
        emit(newState);
      } else {
        emit(state.copyWith(error: "Couldn't not load image"));
      }
    } on Exception catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  //  _onUploadDocument(UploadDocument event, Emitter<KycVerificationState> emit) async {
  //   emit(state.copyWith(status: InProgress()));
  //   final response = await userVerificationRepository.uploadDocument(
  //     DocumentUpload(azureInfo: state.azureInfo, documentImage: event.document),
  //   );
  //   response.fold(
  //     (error) => emit(state.copyWith(status: SubmissionFailure(error))),
  //     (right) => emit(state.copyWith(status: SubmissionSuccess(),primaryFrontImageToken: right)),
  //   );
  // }
}
