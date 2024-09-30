part of 'add_service_price_bloc.dart';

abstract class AddServicePriceEvent {}

class ServiceTypeChanged extends AddServicePriceEvent {
  final String serviceType;
  ServiceTypeChanged(this.serviceType);
}

class PriceChanged extends AddServicePriceEvent {
  final String price;
  PriceChanged(this.price);
}

class SubmitService extends AddServicePriceEvent {
  final CatalogFilter catalogFilter;
  SubmitService(this.catalogFilter);
}
