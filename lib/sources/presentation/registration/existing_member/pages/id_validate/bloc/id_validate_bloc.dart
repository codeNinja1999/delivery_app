import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';

part 'id_validate_event.dart';
part 'id_validate_state.dart';

class IdValidateBloc extends Bloc<IdValidateEvent, IdValidateState> {
  final ExistingMemberRepository existingMemberRepository;
  final CatalogRepository catalogRepository;

  IdValidateBloc({
    required this.existingMemberRepository,
    required this.catalogRepository,
  }) : super(IdValidateState()) {
    on<GetIdTypeCatalog>(_onGetIdTypeCatalog);

    on<AutoValidateChanged>((event, emit) {
      emit(state.copyWith(autoValidate: event.autoValidate));
    });
    on<IdTypeSelected>((event, emit) {
      emit(state.copyWith(idType: event.idType));
    });
    on<IDNumberChanged>((event, emit) {
      emit(state.copyWith(idNumber: event.idNumber));
    });
    on<DateOfBirthSelected>((event, emit) {
      emit(state.copyWith(dateOfBirth: event.dateOfBirth));
    });
    on<TransactionDateSelected>((event, emit) {
      emit(state.copyWith(transactionDate: event.transactionDate));
    });
    on<TransactionIdChanged>((event, emit) {
      emit(state.copyWith(transactionId: event.transactionId));
    });
    on<TransactionAmountChanged>((event, emit) {
      emit(state.copyWith(transactionAmount: event.transactionAmount));
    });
    on<CheckExistingMember>(_onCheckExistingMember);
  }

  _onCheckExistingMember(CheckExistingMember event, Emitter<IdValidateState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final info = CheckExistingMemberInfo(
      idType: state.idType?.id,
      otpProcessId: event.otpProcessId,
      idNumber: state.idNumber.encrypted(key: AppConfig.shared.appKey),
      dateOfBirth: state.dateOfBirth,
      transactionDate: (state.autoValidate) ? state.transactionDate : "",
      transactionAmount: (state.transactionAmount != "" && state.autoValidate)
          ? state.transactionAmount.encrypted(key: AppConfig.shared.appKey)
          : "",
      transactionId: (state.transactionId != "" && state.autoValidate)
          ? state.transactionId.encrypted(key: AppConfig.shared.appKey)
          : "",
    );

    final response = await existingMemberRepository.checkExistingMember(info);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (result) => emit(state.copyWith(
        checkExistingMemberResult: result,
        status: Success(),
      )),
    );
  }

  Future<void> _onGetIdTypeCatalog(
    GetIdTypeCatalog event,
    Emitter<IdValidateState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.fetchIdTypes(
      CatalogFilter(language: "en", countryCode: AppConstants.senderCountryCode),
    );
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (idTypeList) => emit(state.copyWith(
        idTypeList: idTypeList,
        status: InitialStatus(),
      )),
    );
  }
}
