import 'package:fresh_fold_delivery/repository/domain/user/entities/notification/notification_data.dart';

class NotificationListViewModel {
  final String? msgTitle;
  final String? msgBody;
  final String? dateDifference;

  NotificationListViewModel({
    required this.msgTitle,
    required this.msgBody,
    required this.dateDifference,
  });

  factory NotificationListViewModel.fromNotification(NotificationData data) {
    return NotificationListViewModel(
      msgTitle: data.messageTitle ?? "",
      msgBody: data.messageBody ?? "",
      dateDifference: data.timeDifference ?? "",
    );
  }
}
