import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final CatalogRepository catalogRepository;
  final ReceiverRepository receiverRepository;
  PersonalInfoBloc({required this.catalogRepository, required this.receiverRepository}) : super(PersonalInfoState()) {
    on<GetCatalog>(_onGetRelation);
    on<FullNameChanged>((event, emit) => emit(state.copyWith(fullName: event.fullName)));
    on<PhoneNumberChanged>((event, emit) => emit(state.copyWith(phoneNumber: event.phoneNumber)));
    on<SaveBeneficiaryPersonalInfo>((event, emit) => emit(state.copyWith(status: Success())));
    on<RelationSelected>((event, emit) {
      final isRelationOther = event.relation.value == AppConstants.other ? true : false;
      emit(state.copyWith(relation: event.relation, isRelationOther: isRelationOther, relationOtherDetail: ""));
    });

    on<RelationOtherDetailChanged>((event, emit) {
      emit(state.copyWith(relationOtherDetail: event.relationOtherDetail));
    });

    on<GetReceiverPersonalDetail>((event, emit) {
      if (event.isEdit) {
        emit(state.copyWith(
          isEdit: event.isEdit,
          fullName: event.detailedReceiver?.personalInfo?.fullName,
          relation: event.detailedReceiver?.personalInfo?.relation,
          phoneNumber: event.detailedReceiver?.personalInfo?.mobile,
          isRelationOther: (event.detailedReceiver?.personalInfo?.relation?.id == AppConstants.other) ? true : false,
          relationOtherDetail: (event.detailedReceiver?.personalInfo?.relation?.id == AppConstants.other)
              ? event.detailedReceiver?.personalInfo?.relationAlternative
              : "",
        ));
      }
    });
  }

  Future<bool> _onGetRelation(
    PersonalInfoEvent event,
    Emitter<PersonalInfoState> emit,
  ) async {
    final response = await catalogRepository.fetchrelations(CatalogFilter(language: "en"));
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (relationList) => state.copyWith(relationList: relationList),
    ));
    return true;
  }
}
