import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class ChangeProfilePicRepository {
//Change Profile pic
  Future<Either<Exception, ChangeProfilePicList>> changeProfilePic(ChangeProfilePicInfo picData);
}
