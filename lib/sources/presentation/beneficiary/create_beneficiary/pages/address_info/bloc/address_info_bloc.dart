import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'address_info_event.dart';
part 'address_info_state.dart';

class AddressInfoBloc extends Bloc<AddressInfoEvent, AddressInfoState> {
  final CatalogRepository catalogRepository;
  ReceiverRepository receiverRepository;
  UserUtilitiesRepository userUtilitiesRepository;

  AddressInfoBloc({
    required this.catalogRepository,
    required this.receiverRepository,
    required this.userUtilitiesRepository,
  }) : super(AddressInfoState()) {
    on<GetReceiver>(_onGetReceiver);
    on<ProcessBeneficiary>(_onProcessBeneficiary);
    on<ZipCodeChanged>((event, emit) => emit(state.copyWith(zipCode: event.zipCode)));
    on<StateChanged>((event, emit) => emit(state.copyWith(states: event.states.value)));
    on<AddressChanged>((event, emit) => emit(state.copyWith(address: event.address)));
    on<FetchReceiverDetail>(_onFetchReceiverDetail);
  }

  void _onGetReceiver(GetReceiver event, Emitter<AddressInfoState> emit) {
    final detailedReceiver = event.detailedReceiver;
    emit(state.copyWith(
      receivingCountry: detailedReceiver?.contactInfo?.receivingCountry,
      address: detailedReceiver?.contactInfo?.streetAddress,
      zipCode: detailedReceiver?.contactInfo?.postalCode,
      states: detailedReceiver?.contactInfo?.state?.id,
      fromSendMoney: event.fromSendMoney,
      isEdit: event.isEdit,
    ));
  }

  void _onProcessBeneficiary(ProcessBeneficiary event, Emitter<AddressInfoState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await makeBeneficiary(event);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (detailedReceiver) {
        receiverRepository.getReceiverList();
        // add(FetchReceiverDetail(receiverId: beneficiaryId));
        emit(state.copyWith(status: Success(), detailedReceiver: detailedReceiver));
      },
    );
  }

  void _onFetchReceiverDetail(FetchReceiverDetail event, Emitter<AddressInfoState> emit) async {
    // emit(state.copyWith(status: InProgress()));
    final response = await receiverRepository.getReceiverDetail(event.receiverId);

    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (detailedReceiver) => emit(state.copyWith(detailedReceiver: detailedReceiver)),
    );
  }

  Future<Either<Exception, DetailedReceiver>> makeBeneficiary(ProcessBeneficiary event) async {
    if (state.isEdit) {
      final response = await receiverRepository.updateReceiver(event.receiverId, event.receiver);
      return response;
    } else {
      final response = await receiverRepository.addReceiver(event.receiver);
      return response;
    }
  }
}
