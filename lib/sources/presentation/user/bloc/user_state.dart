part of 'user_bloc.dart';

class UserState extends Equatable {
  final Location? location;
  final ServiceType? service;
  final DateTime? pickupDate;
  final String? totalWeight;
  final bool noPetHair;
  final bool noBlood;
  final bool noBiohazard;
  final User? user;

  const UserState({
    this.location,
    this.service,
    this.pickupDate,
    this.totalWeight,
    this.noBiohazard = true,
    this.noBlood = true,
    this.noPetHair = true,
    this.user,
  });

  UserState copyWith({
    Location? location,
    ServiceType? service,
    DateTime? pickupDate,
    String? totalWeight,
    bool? noPetHair,
    bool? noBlood,
    bool? noBiohazard,
    User? user,
  }) {
    return UserState(
      location: location ?? this.location,
      service: service ?? this.service,
      pickupDate: pickupDate ?? this.pickupDate,
      totalWeight: totalWeight ?? this.totalWeight,
      noPetHair: noPetHair ?? this.noPetHair,
      noBlood: noBlood ?? this.noBlood,
      noBiohazard: noBiohazard ?? this.noBiohazard,
      user: user ?? this.user,
    );
  }


  

  @override
  List<Object?> get props => [
        location,
        service,
        totalWeight,
        pickupDate,
        noBiohazard,
        noBlood,
        noPetHair,
      ];
}
