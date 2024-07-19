import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/beneficiary_detail_view_model.dart';

part 'beneficiary_detail_event.dart';
part 'beneficiary_detail_state.dart';

class BeneficiaryDelSuccess extends FormStatus {}

class BeneficiaryDetailBloc extends Bloc<BeneficiaryDetailEvent, BeneficiaryDetailState> {
  final ReceiverRepository receiverRepository;
  late String beneficiaryID;

  BeneficiaryDetailBloc({required this.receiverRepository}) : super(BeneficiaryDetailState()) {
    on<GetReceiverDetail>(_onGetReceiverDetail);
    on<DeleteReceiverDetail>(_onDeleteReceiverDetail);
  }

  void _onDeleteReceiverDetail(DeleteReceiverDetail event, Emitter<BeneficiaryDetailState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await receiverRepository.deleteReceiver(beneficiaryID);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (right) {
          receiverRepository.getReceiverList();
          return state.copyWith(status: BeneficiaryDelSuccess());
        },
      ),
    );
  }

  void _onGetReceiverDetail(GetReceiverDetail event, Emitter<BeneficiaryDetailState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await receiverRepository.getReceiverDetail(beneficiaryID);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (receiver) => state.copyWith(
          status: Success(),
          detailedReceiver: receiver,
          receiver: BeneficiaryDetailViewModel.fromDetailReceiver(receiver),
        ),
      ),
    );
  }
}
