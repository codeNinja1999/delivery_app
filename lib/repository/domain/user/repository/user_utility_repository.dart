import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/notification/notification_data.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';

import '../../common/model/date_filter.dart';
import '../../common/model/pagination_filter.dart';
import '../../pickup_order/admin_order_result.dart';
import '../../pickup_order/pickup_order.dart';
import '../../pickup_order/pickup_order_result.dart';
import '../entities/analytic_data_info.dart';
import '../entities/registration/operator_registration_info.dart';

abstract class UserUtilitiesRepository {
  clearSavedUser();
  dispose();
  Future<String> getUserInfo();
  Stream<DetailedUser?> userInfo();
  DetailedUser? getUserDetailed();
  Future<Either<Exception, String>> logoutUser();
  Future<Either<Exception, AnalyticDataInfo>> fetchAnalyticData(DateFilter filter);
  Future<Either<Exception, List<DetailedUser>>> getUserList(PaginationFilter filter);
  Future<Either<Exception, String>> updateUserProfile(User userInfo);
  Future<Either<Exception, String>> createOrder(PickupOrder pickupOrder);
  Future<Either<Exception, List<PickupOrderResult>>> getOrderHistory(PaginationFilter filter);
  Future<Either<Exception, List<AdminPickupOrderResult>>> getAdminOrderHistory(PaginationFilter filter);
  Future<Either<Exception, List<NotificationData>>> getUserNotification();

  Future<Either<Exception, String?>> deleteOperator(DetailedUser operator);
  Future<Either<Exception, String?>> updateOperator(OperatorRegistrationInfo operator);
  Future<Either<Exception, List<DetailedUser>>> getOperatorList(PaginationFilter filter);
  // Future<Either<Exception, DetailedUser>> updateUserInfo(UserUpdateInfo data);
}
