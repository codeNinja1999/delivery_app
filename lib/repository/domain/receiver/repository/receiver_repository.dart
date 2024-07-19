import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver.dart';

abstract class ReceiverRepository {
  Future<Either<Exception, DetailedReceiver>> addReceiver(Receiver receiverInfo);

  Future<Either<Exception, DetailedReceiver>> updateReceiver(String id, Receiver appInfo);

  Future<Either<Exception, String>> deleteReceiver(String id);

  Future<Either<Exception, DetailedReceiver>> getReceiverDetail(String id);

  Stream<List<DetailedReceiver>?> receiverList();

  Future<String> getReceiverList();
}
