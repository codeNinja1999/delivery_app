import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../core/app_core.dart';

part 'id_selection_event.dart';
part 'id_selection_state.dart';

class IdSelectionBloc extends Bloc<IdSelectionEvent, IdSelectionState> {
  final CatalogRepository catalogRepository;
  final UserUtilitiesRepository userUtilitiesRepository;

  IdSelectionBloc({required this.catalogRepository, required this.userUtilitiesRepository}) : super(IdSelectionState()) {
    on<GetIdCatalog>(_getIDTypes);
    on<IdDocumentSubscription>(_onIdDocumentSubscription);

    on<DocumentTypeChanged>((event, emit) {
      emit(state.copyWith(documentType: event.documentType));
    });
  }

  Future<void> _getIDTypes(
    GetIdCatalog event,
    Emitter<IdSelectionState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.fetchIdTypes(
      CatalogFilter(language: "en", countryCode: AppConstants.senderCountryCode),
    );
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (documentTypeList) => emit(
        state.copyWith(documentTypeList: documentTypeList, status: Success()),
      ),
    );
  }

  Future<void> _onIdDocumentSubscription(
    IdDocumentSubscription event,
    Emitter<IdSelectionState> emit,
  ) async {
    emit(state.copyWith(status: state.status));
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (userInfo) =>
          userInfo != null ? state.copyWith(documentType: userInfo.identificationInfo?.idType, status: state.status) : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }
}
