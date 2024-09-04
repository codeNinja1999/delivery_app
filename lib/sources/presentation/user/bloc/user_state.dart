part of 'user_bloc.dart';

class UserState extends Equatable {
  final Location? location;
  final ServiceType? service;
  final DateTime? pickupDate;
  final String? totalWeight;
  final HygieneInfo? hygieneInfo;
  final File? receiptImage;
  final User? user;

  PickupOrder makeData(String? additionalInformation, File? receiptImage) => _makeData(additionalInformation, receiptImage);

  const UserState({
    this.location,
    this.service,
    this.pickupDate,
    this.totalWeight,
    this.hygieneInfo,
    this.receiptImage,
    this.user,
  });

  UserState copyWith({
    Location? location,
    ServiceType? service,
    DateTime? pickupDate,
    String? totalWeight,
    HygieneInfo? hygieneInfo,
    File? receiptImage,
    User? user,
  }) {
    return UserState(
      location: location ?? this.location,
      service: service ?? this.service,
      pickupDate: pickupDate ?? this.pickupDate,
      totalWeight: totalWeight ?? this.totalWeight,
      hygieneInfo: hygieneInfo ?? this.hygieneInfo,
      receiptImage: receiptImage ?? this.receiptImage,
      user: user ?? this.user,
    );
  }

  _makeData(String? additionalInformation, File? receiptImage ) {
    return PickupOrder(
      serviceType: service,
      pickupDate: pickupDate,
      actualWeight: totalWeight,
      userContactInfo: user?.contactInfo,
      additionalInformation: additionalInformation,
      receiptImage: receiptImage,
    );
  }

  @override
  List<Object?> get props => [
        location,
        service,
        totalWeight,
        pickupDate,
        hygieneInfo,
        receiptImage,
        user,
      ];
}
