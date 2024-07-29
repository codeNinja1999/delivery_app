import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/notification_list_view_model.dart';

part 'notification_list_event.dart';
part 'notification_list_state.dart';

class NotificationListBloc extends Bloc<NotificationListEvent, NotificationListState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  NotificationListBloc({required this.userUtilitiesRepository}) : super(NotificationListState()) {
    on<GetNotificationList>(
      (event, emit) async {
        emit(state.copyWith(status: InProgress()));
        final response = await userUtilitiesRepository.getUserNotification();
        emit(
          response.fold(
            (error) => state.copyWith(status: SubmissionFailure(error)),
            (notificationList) {
              final list = notificationList.map((item) => NotificationListViewModel.fromNotification(item)).toList();
              return state.copyWith(
                defaultNotificationList: list,
                notificationList: list,
                status: Success(),
              );
            },
          ),
        );
      },
    );
  }
}
