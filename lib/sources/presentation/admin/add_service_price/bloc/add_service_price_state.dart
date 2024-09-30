part of 'add_service_price_bloc.dart';

class AddServicePriceState extends Equatable {
  final String? serviceType;
  final String? price;
  final FormStatus status;

  AddServicePriceState({this.serviceType, this.price, status}) : status = (status != null) ? status : InitialStatus();

  @override
  List<Object?> get props => [serviceType, price, status];

  AddServicePriceState copyWith({String? serviceType, String? price, FormStatus? status}) {
    return AddServicePriceState(
      serviceType: serviceType ?? this.serviceType,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }

  CatalogFilter makeData() {
    return CatalogFilter(
      price: price,
      serviceName: serviceType,
    );
  }
}
