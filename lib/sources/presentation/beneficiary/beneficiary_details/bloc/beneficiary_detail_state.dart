part of 'beneficiary_detail_bloc.dart';

class BeneficiaryDetailState extends Equatable {
  final BeneficiaryDetailViewModel? receiver;
  final DetailedReceiver? detailedReceiver;
  final FormStatus status;

  BeneficiaryDetailState({this.receiver, this.detailedReceiver,status})
      : status = (status != null) ? status : InitialStatus();

  BeneficiaryDetailState copyWith({
    BeneficiaryDetailViewModel? receiver,
    DetailedReceiver? detailedReceiver,
    FormStatus? status,
  }) {
    return BeneficiaryDetailState(
      receiver: receiver ?? this.receiver,
      detailedReceiver: detailedReceiver ?? this.detailedReceiver,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [receiver,detailedReceiver, status];
}
