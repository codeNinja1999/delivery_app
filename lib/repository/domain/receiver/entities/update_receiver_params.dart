import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver.dart';

class UpdateReceiverParams {
  UpdateReceiverParams({required this.id, this.receiver});

  final String id;
  final Receiver? receiver;
}
