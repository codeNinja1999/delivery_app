part of 'service_selection_bloc.dart';

class ServiceSelectionState extends Equatable {
  final ServiceType? selectedServiceType;
  final List<ServiceType> serviceTypeList;
  final String totalWeight;
  final int totalAmount;
  final bool noPetHair;
  final bool noBlood;
  final bool noBiohazard;
  final FormStatus status;

  HygieneInfo get makeData => _makeData();
  String? get serviceTypeValidation => (selectedServiceType != null) ? null : "Please select service type";
  String? get locationValidation => (totalWeight != "") ? null : "Please enter weight";

  ServiceSelectionState({
    this.selectedServiceType,
    this.totalWeight = "",
    this.totalAmount =0,
    this.serviceTypeList = const [],
    this.noPetHair = false,
    this.noBlood = false,
    this.noBiohazard = false,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ServiceSelectionState copyWith({
    ServiceType? selectedServiceType,
    List<ServiceType>? serviceTypeList,
    String? totalWeight,
    int? totalAmount,
    bool? noPetHair,
    bool? noBlood,
    bool? noBiohazard,
    FormStatus? status,
  }) {
    return ServiceSelectionState(
      selectedServiceType: selectedServiceType ?? this.selectedServiceType,
      serviceTypeList: serviceTypeList ?? this.serviceTypeList,
      totalWeight: totalWeight ?? this.totalWeight,
      totalAmount: totalAmount ?? this.totalAmount,
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
        selectedServiceType,
        serviceTypeList,
        totalWeight,
        totalAmount,
        noPetHair,
        noBlood,
        noBiohazard,
        status,
      ];
}
