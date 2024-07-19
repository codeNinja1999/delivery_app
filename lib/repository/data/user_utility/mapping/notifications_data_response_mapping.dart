import 'package:fresh_fold_delivery/repository/data/user_utility/model/notifications/notifications_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/notification/notification_data.dart';

extension NotificationsRequestDataMapping on NotificationResultList {
  NotificationData toDomain() {
    final notificationData = NotificationData(
      transactionId: fileUrl,
      messageType: msgBody,
      messageTitle: msgTitle,
      sentTs: fileUrl,
      messageBody: msgBody,
      lastUpdateTs: fileUrl,
      confirmedFlag: country,
      timeDifference: dateDifference,
    );
    return notificationData;
  }
}
