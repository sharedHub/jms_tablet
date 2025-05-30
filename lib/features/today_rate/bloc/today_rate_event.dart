import '../model/today_rate_model.dart';

abstract class MetalRatesEvent {}

class LoadMetalRates extends MetalRatesEvent {}

class AddMetalRate extends MetalRatesEvent {
  final MetalRate rate;
  AddMetalRate({required this.rate});
}

class UpdateMetalRate extends MetalRatesEvent {
  final MetalRate oldRate;
  final MetalRate newRate;
  UpdateMetalRate({required this.oldRate, required this.newRate});
}

class DeleteMetalRate extends MetalRatesEvent {
  final MetalRate rate;
  DeleteMetalRate({required this.rate});
}

class RefreshMetalRates extends MetalRatesEvent {}
