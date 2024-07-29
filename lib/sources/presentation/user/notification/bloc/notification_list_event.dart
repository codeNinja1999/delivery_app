part of 'notification_list_bloc.dart';

abstract class NotificationListEvent {}

class GetNotificationList extends NotificationListEvent {}

class NotificationListSubscriptionRequested extends NotificationListEvent {}

class SearchNotificationChanged extends NotificationListEvent {
  final String? searchString;
  SearchNotificationChanged(this.searchString);
}
