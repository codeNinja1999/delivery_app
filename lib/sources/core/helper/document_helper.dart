import '../../resources/resources.dart';

enum DocumentPosition { front, back, thickness }

String image(String? value, DocumentPosition position) => fromString(value: value, position: position);

String fromString({String? value, required DocumentPosition position}) {
  if (position == DocumentPosition.front) {
    switch (value) {
      case "Drivers License":
        return AppImages.driverLicenseFront;

      default:
        return AppImages.alienRegistrationFront;
    }
  } else if (position == DocumentPosition.back) {
    switch (value) {
      case "Drivers License":
        return AppImages.driverLicenseBack;

      default:
        return AppImages.alienRegistrationBack;
    }
  } else {
    switch (value) {
      case "Drivers License":
        return AppImages.thickness;

      default:
        return AppImages.thickness;
    }
  }
}
