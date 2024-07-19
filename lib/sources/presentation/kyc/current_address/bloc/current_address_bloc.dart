import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import '../../../../core/app_core.dart';

part 'current_address_event.dart';
part 'current_address_state.dart';

class PostalAddressSelectedSuccess extends FormStatus {}

class SetAddressSuccess extends FormStatus {}

class CurrentAddressBloc extends Bloc<CurrentAddressEvent, CurrentAddressState> {
  final CatalogRepository catalogRepository;
  final UserUtilitiesRepository userUtilitiesRepository;

  CurrentAddressBloc({required this.userUtilitiesRepository, required this.catalogRepository})
      : super(CurrentAddressState()) {
    on<CurrentAddressSubscriptionRequested>(_onCurrentAddressSubscriptionRequested);
    on<SearchPostalAddress>(_getPostalCode);
    on<CityChanged>((event, emit) => emit(state.copyWith(city: event.city)));
    on<StreetAddressChanged>((event, emit) => emit(state.copyWith(streetAddress: event.streetAddress)));
    on<StateSelected>((event, emit) => emit(state.copyWith(state: event.state)));
    on<ZipCodeChanged>((event, emit) => emit(state.copyWith(zipCode: event.zipCode)));
    on<JapaneseSenderAddressChanged>(
        (event, emit) => emit(state.copyWith(japaneseSenderAddress: event.japaneseSenderAddress)));
    on<JapaneseStreetAddressChanged>(
        (event, emit) => emit(state.copyWith(japaneseStreetAddress: event.japaneseStreetAddressChanged)));
    on<PostalAddressSelected>((event, emit) {
      emit(state.copyWith(
        zipCode: event.postalAddress?.postalAddress,
        streetAddress: event.postalAddress?.street,
        city: event.postalAddress?.city?.value,
        japaneseSenderAddress: event.postalAddress?.street2,
        state: event.postalAddress?.state?.id ?? "",
        status: PostalAddressSelectedSuccess(),
      ));
    });
  }

  _getPostalCode(
    SearchPostalAddress event,
    Emitter<CurrentAddressState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.fetchpostalCode(
      CatalogFilter(language: "en", countryCode: state.zipCode),
    );
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (postalAddressList) => state.copyWith(postalAddressList: postalAddressList),
    ));
  }

  Future<void> _onCurrentAddressSubscriptionRequested(
    CurrentAddressSubscriptionRequested event,
    Emitter<CurrentAddressState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (userInfo) => userInfo != null
          ? state.copyWith(
              zipCode: userInfo.contactInfo?.postalCode,
              city: userInfo.contactInfo?.city?.value,
              state: userInfo.contactInfo?.state?.value,
              streetAddress: userInfo.contactInfo?.streetAddress,
              japaneseStreetAddress: userInfo.contactInfo?.japaneseStreetAddress,
              japaneseSenderAddress: userInfo.contactInfo?.japaneseSenderAddress,
              status: SetAddressSuccess(),
            )
          : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }
}
