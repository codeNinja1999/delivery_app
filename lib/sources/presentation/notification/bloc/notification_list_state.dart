part of 'notification_list_bloc.dart';

class NotificationListState extends Equatable {
  final List<NotificationListViewModel> notificationList;
  final List<NotificationListViewModel> defaultNotificationList;
  final FormStatus status;

  NotificationListState({notificationList, defaultNotificationList, status})
      : defaultNotificationList = (defaultNotificationList != null) ? defaultNotificationList : [],
        notificationList = (notificationList != null) ? notificationList : [],
        status = (status != null) ? status : InitialStatus();

  NotificationListState copyWith({
    List<NotificationListViewModel>? defaultNotificationList,
    List<NotificationListViewModel>? notificationList,
    FormStatus? status,
  }) {
    return NotificationListState(
      defaultNotificationList: defaultNotificationList ?? this.defaultNotificationList,
      notificationList: notificationList ?? this.notificationList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [notificationList, defaultNotificationList, status];
}
