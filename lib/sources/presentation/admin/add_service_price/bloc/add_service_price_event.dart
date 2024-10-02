part of 'add_service_price_bloc.dart';

abstract class AddServicePriceEvent {}

class GetServiceType extends AddServicePriceEvent {}

class ServiceNameChanged extends AddServicePriceEvent {
  final String serviceName;
  ServiceNameChanged(this.serviceName);
}

class PriceChanged extends AddServicePriceEvent {
  final String price;
  PriceChanged(this.price);
}

class SubmitService extends AddServicePriceEvent {}
