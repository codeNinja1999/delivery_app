import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../../../app_account_utility.dart';

part 'user_personal_info_event.dart';
part 'user_personal_info_state.dart';

class UserPersonalInfoBloc extends Bloc<UserPersonalInfoEvent, UserPersonalInfoState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  final ChangeProfilePicRepository changeProfilePicRepository;

  UserPersonalInfoBloc({required this.userUtilitiesRepository, required this.changeProfilePicRepository})
      : super(UserPersonalInfoState()) {
    on<UserInfoSubscriptionRequested>(_onSubscriptionRequested);
    on<GetPersonalInfo>((event, emit) async {
      emit(state.copyWith(status: InProgress()));
      await userUtilitiesRepository.getUserInfo();
    });
    on<GetImage>(_onGetImage);

    on<ChangeProfilePic>((event, emit) async {
      emit(state.copyWith(status: InProgress()));
      final changeProfilePic = ChangeProfilePicInfo(imageSelfie: event.profileImage);
      final response = await changeProfilePicRepository.changeProfilePic(changeProfilePic);
      emit(
        response.fold((error) => state.copyWith(status: SubmissionFailure(Exception(error))), (profileimageInfo) {
          return state.copyWith(profileImage: profileimageInfo, status: Success());
        }),
      );
      await userUtilitiesRepository.getUserInfo();
    });
  }

  Future<void> _onSubscriptionRequested(
    UserInfoSubscriptionRequested event,
    Emitter<UserPersonalInfoState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));

    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (info) {
        final viewModel = UserPersonalInfoViewModel.fromTransaction(info);
        return state.copyWith(personalInfoViewModel: viewModel, status: Success());
      },
      onError: (error, __) {
        return state;
      },
    );
  }

  Future<void> _onGetImage(
    GetImage event,
    Emitter<UserPersonalInfoState> emit,
  ) async {
    final imgPicker = ImagePicker();
    XFile? imageFile;

    imageFile = await imgPicker.pickImage(
      source: (event.scanBy == ScanBy.camera) ? ImageSource.camera : ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
      maxHeight: 480,
      maxWidth: 640,
      imageQuality: 50,
    );

    if (imageFile != null) {
      final image = File(imageFile.path);
      final changeProfilePic = ChangeProfilePicInfo(
        imageSelfie: image,
      );
      final response = await changeProfilePicRepository.changeProfilePic(changeProfilePic);
      emit(
        response.fold((error) => state.copyWith(status: SubmissionFailure(Exception(error))), (profileimageInfo) {
          return state.copyWith(profileImage: profileimageInfo, status: Success());
        }),
      );
      await userUtilitiesRepository.getUserInfo();
    } else {
      emit(state.copyWith(status: SubmissionFailure(Exception("Could not load image"))));
    }
  }
}
