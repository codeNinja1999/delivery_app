import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/notification/notification_data.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';

import '../../common/model/date_filter.dart';
import '../../common/model/pagination_filter.dart';
import '../../pickup_order/pickup_order.dart';
import '../entities/analytic_data_info.dart';
import '../entities/operator/operator_entities.dart';

abstract class UserUtilitiesRepository {
  clearSavedUser();
  Future<String> getUserInfo();
  Stream<DetailedUser?> userInfo();
  Future<Either<Exception, String>> logoutUser();
  Future<Either<Exception, AnalyticDataInfo>> fetchAnalyticData(DateFilter filter);
  Future<Either<Exception, List<DetailedUser>>> getUserList(PaginationFilter filter);
  Future<Either<Exception, String>> updateUserProfile(User userInfo);
  Future<Either<Exception, String>> createOrder(PickupOrder pickupOrder);
  Future<Either<Exception, List<NotificationData>>> getUserNotification();

  Future<Either<Exception, String?>> deleteOperator(String operatorId);
  Future<Either<Exception, String?>> addOperator(Operator operatorInfo);
  Future<Either<Exception, String?>> updateOperator(Operator operatorInfo);
  Future<Either<Exception, List<DetailedOperator>>> getOperatorList(PaginationFilter filter);
  // Future<Either<Exception, DetailedUser>> updateUserInfo(UserUpdateInfo data);
}
