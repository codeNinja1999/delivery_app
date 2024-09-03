part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  final String? additionalInformation;
  final FormStatus status;

  CheckoutState({this.additionalInformation, status}) : status = (status != null) ? status : InitialStatus();

  CheckoutState copyWith({
    String? additionalInformation,
    FormStatus? status,
  }) {
    return CheckoutState(
      additionalInformation: additionalInformation ?? this.additionalInformation,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [additionalInformation, status];
}
