part of 'add_service_price_bloc.dart';

class AddServicePriceState extends Equatable {
  final String price;
  final String serviceId;
  final String serviceName;
  final FormStatus status;

  AddServicePriceState({
    this.price = "",
    this.serviceId = "",
    this.serviceName = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();


  String? get priceValidation => (price != "") ? null : LocaleKeys.priceErrorMessage.value;
  String? get serviceNameValidation => (serviceName != "") ? null : LocaleKeys.serviceNameErrorMessage.value;

  AddServicePriceState copyWith({String? serviceName, String? price, String? serviceId, FormStatus? status}) {
    return AddServicePriceState(
      price: price ?? this.price,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      status: status ?? this.status,
    );
  }

  CatalogFilter makeData() {
    return CatalogFilter(
      price: price,
      id: serviceId,
      serviceName: serviceName,
    );
  }

  @override
  List<Object?> get props => [serviceName, price, serviceId, status];
}
