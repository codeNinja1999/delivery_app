part of 'service_selection_bloc.dart';

class ServiceSelectionState extends Equatable {
  final ServiceType? serviceType;
  final List<ServiceType>? serviceTypeList;
  final String totalWeight;
  final bool noPetHair;
  final bool noBlood;
  final bool noBiohazard;
  final FormStatus status;

  HygieneInfo get makeData => _makeData();
  String? get serviceTypeValidation => (serviceType != null) ? null : "Please select service type";
  String? get locationValidation => (totalWeight != "") ? null : "Please enter weight";

  ServiceSelectionState({
    this.serviceType,
    this.totalWeight = "",
    this.serviceTypeList = const [],
    this.noPetHair = false,
    this.noBlood = false,
    this.noBiohazard = false,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ServiceSelectionState copyWith({
    ServiceType? serviceType,
    List<ServiceType>? serviceTypeList,
    String? totalWeight,
    bool? noPetHair,
    bool? noBlood,
    bool? noBiohazard,
    FormStatus? status,
  }) {
    return ServiceSelectionState(
      serviceType: serviceType ?? this.serviceType,
      serviceTypeList: serviceTypeList ?? this.serviceTypeList,
      totalWeight: totalWeight ?? this.totalWeight,
      noPetHair: noPetHair ?? this.noPetHair,
      noBlood: noBlood ?? this.noBlood,
      noBiohazard: noBiohazard ?? this.noBiohazard,
      status: status ?? InitialStatus(),
    );
  }

  _makeData() {
    return HygieneInfo(containBiohazard: noBiohazard, containBlood: noBlood, containPetHair: noPetHair);
  }

  @override
  List<Object?> get props => [
        serviceType,
        serviceTypeList,
        totalWeight,
        noPetHair,
        noBlood,
        noBiohazard,
        status,
      ];
}
