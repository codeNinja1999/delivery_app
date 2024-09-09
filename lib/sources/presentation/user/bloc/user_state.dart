part of 'user_bloc.dart';

class UserState extends Equatable {
  final Location? location;
  final ServiceType? service;
  final DateTime? pickupDate;
  final String? totalWeight;
  final String? totalAmount;
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
    this.totalAmount,
    this.receiptImage,
    this.user,
  });

  UserState copyWith({
    Location? location,
    ServiceType? service,
    DateTime? pickupDate,
    String? totalWeight,
    String? totalAmount,
    HygieneInfo? hygieneInfo,
    File? receiptImage,
    User? user,
  }) {
    return UserState(
      location: location ?? this.location,
      service: service ?? this.service,
      pickupDate: pickupDate ?? this.pickupDate,
      totalWeight: totalWeight ?? this.totalWeight,
      totalAmount: totalAmount ?? this.totalAmount,
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
      totalAmount: totalAmount,
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
        pickupDate,totalAmount,
        hygieneInfo,
        receiptImage,
        user,
      ];
}
