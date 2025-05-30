import '../model/today_rate_model.dart';

abstract class MetalRatesState {}

class MetalRatesInitial extends MetalRatesState {}

class MetalRatesLoading extends MetalRatesState {}

class MetalRatesLoaded extends MetalRatesState {
  final List<MetalRate> rates;
  MetalRatesLoaded({required this.rates});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetalRatesLoaded &&
        other.rates.length == rates.length &&
        other.rates.every((rate) => rates.contains(rate));
  }

  @override
  int get hashCode => rates.hashCode;
}

class MetalRatesError extends MetalRatesState {
  final String message;
  MetalRatesError({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetalRatesError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class MetalRateAdded extends MetalRatesState {
  final List<MetalRate> rates;
  MetalRateAdded({required this.rates});
}

class MetalRateUpdated extends MetalRatesState {
  final List<MetalRate> rates;
  MetalRateUpdated({required this.rates});
}

class MetalRateDeleted extends MetalRatesState {
  final List<MetalRate> rates;
  MetalRateDeleted({required this.rates});
}
