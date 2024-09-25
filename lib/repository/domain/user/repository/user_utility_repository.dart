import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/notification/notification_data.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';

import '../../common/model/pagination_filter.dart';
import '../../pickup_order/pickup_order.dart';

abstract class UserUtilitiesRepository {
  clearSavedUser();
  Future<String> getUserInfo();
  Stream<DetailedUser?> userInfo();
  Future<Either<Exception, String>> logoutUser();
  Future<Either<Exception, List<DetailedUser>>> getUserList(PaginationFilter filter);
  Future<Either<Exception, String>> updateUserProfile(User userInfo);
  Future<Either<Exception, String>> createOrder(PickupOrder pickupOrder);
  Future<Either<Exception, List<NotificationData>>> getUserNotification();
  // Future<Either<Exception, DetailedUser>> updateUserInfo(UserUpdateInfo data);
}
