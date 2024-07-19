import 'package:fresh_fold_delivery/repository/data/change_profile_pic/model/change_profile_pic_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/change_profile_pic/entities/change_profile_pic_info.dart';

extension ChangeProfilePicRequestDataMapping on ChangeProfilePicInfo {
  ChangeProfileRequestModel toRequestData() {
    final requestData = ChangeProfileRequestModel(imageSelfie: imageSelfie);
    return requestData;
  }
}
