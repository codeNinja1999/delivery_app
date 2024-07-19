import 'package:fresh_fold_delivery/repository/data/change_profile_pic/model/change_profile_pic_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/change_profile_pic/entities/change_profile_pic_list.dart';

extension EntertainmentResponseMapping on ChangeProfileResponse {
  ChangeProfilePicList toDomain() {
    return ChangeProfilePicList(
      fileName: fileName,
    );
  }
}
