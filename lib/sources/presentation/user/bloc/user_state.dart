part of 'user_bloc.dart';

class UserState extends Equatable {
  final Location? location;
  final ServiceType? service;
  final DateTime? pickupDate;
  final String? totalWeight;
  final HygieneInfo? hygieneInfo;
  final User? user;

  PickupOrder makeData(String? additionalInformation) => _makeData(additionalInformation);

  const UserState({
    this.location,
    this.service,
    this.pickupDate,
    this.totalWeight,
    this.hygieneInfo,
    this.user,
  });

  UserState copyWith({
    Location? location,
    ServiceType? service,
    DateTime? pickupDate,
    String? totalWeight,
    HygieneInfo? hygieneInfo,
    User? user,
  }) {
    return UserState(
      location: location ?? this.location,
      service: service ?? this.service,
      pickupDate: pickupDate ?? this.pickupDate,
      totalWeight: totalWeight ?? this.totalWeight,
      hygieneInfo: hygieneInfo ?? this.hygieneInfo,
      user: user ?? this.user,
    );
  }

  _makeData(String? additionalInformation) {
    return PickupOrder(
      serviceType: service,
      pickupDate: pickupDate,
      actualWeight: totalWeight,
      userContactInfo: user?.contactInfo,
      additionalInformation: additionalInformation,
    );
  }

  @override
  List<Object?> get props => [
        location,
        service,
        totalWeight,
        pickupDate,
        hygieneInfo,
        user,
      ];
}
