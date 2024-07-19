import 'dart:io';

class ChangeProfileRequestModel {
  File? imageSelfie;

  ChangeProfileRequestModel({
    this.imageSelfie,
  });

  factory ChangeProfileRequestModel.fromJson(Map<String, dynamic> json) => ChangeProfileRequestModel(
        imageSelfie: json["image_selfie"],
      );

  Map<String, dynamic> toJson() => {
        "image_selfie": imageSelfie,
      };
}
